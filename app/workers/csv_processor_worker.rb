require 'csv'

class CsvProcessorWorker
  include Sidekiq::Worker 
  include Sidekiq::Status::Worker

  def perform(encoded_csv_content, user_id)
    csv_content = Base64.decode64(encoded_csv_content)
    texts_to_embed = []
    ids = []
    csv_rows = CSV.parse(csv_content, headers: true)
    # Total Progress of task
    total_rows = csv_rows.count
    total total_rows
    store(message: 'Starting Upload')
    csv_rows.each_with_index do |row, index|
      highlight_hash = {
        highlight: row['Highlight'],
        book_title: row['Book Title'],
        book_author: row['Book Author'],
        amazon_book_id: row['Amazon Book ID'],
        note: row['Note'],
        color: row['Color'],
        tags: row['Tags'],
        location_type: row['Location Type'],
        location: row['Location'],
        highlighted_at: row['Highlighted at'],
        document_tags: row['Document tags'],
        user_id: user_id
      }
      highlight = Highlight.create!(highlight_hash)
      texts_to_embed.push(highlight.to_greymatter)
      ids.push(highlight.id)

      # Report progress
      at(index + 1, "Processing row #{index + 1} of #{total_rows}")
    end
    client = Langchain::Vectorsearch::Pgvector.new(                               
      url: ENV['DATABASE_URL'],                                                                             
      index_name: 'highlights',                                                                       
      llm: Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_KEY']),                                          
      namespace: 'openai'                                                                              
    )                                                                                                   
    store(message: 'Embedding Notes')
    client.upsert_texts(texts: texts_to_embed, ids: ids)
    store(message: 'Notes Embedded')

    # Cleanup
    File.delete(file_path)
  end
end
