class Highlight < ApplicationRecord
  require 'csv'
  belongs_to :user

  def self.import(file, user_id)
    texts_to_embed = []
    ids = []
    CSV.foreach(file.path, headers: true).each_with_index do |row, index|
      break if index >= 5 # Stop processing after the first 5 rows
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
      highlight = create!(highlight_hash)
      texts_to_embed.push(highlight.to_greymatter)
      ids.push(highlight.id)
    end
    client = Langchain::Vectorsearch::Pgvector.new(                               
      url: ENV['DATABASE_URL'],                                                                             
      index_name: 'highlights',                                                                       
      llm: Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_KEY']),                                          
      namespace: 'openai'                                                                              
    )                                                                                                   
    client.upsert_texts(texts: texts_to_embed, ids: ids)
    puts texts_to_embed
    puts ids
  end

  def to_greymatter
    metadata = self.attributes.except("highlight", "id", "created_at", "updated_at").compact.map do |key, value|
      "#{key}: #{value}"
    end.join("\n")

    "---\n#{metadata}\n---\n#{self.highlight}"
  end
end
