require 'pg'

namespace :update_highlights do
  desc "Update highlights vector"
  task update: :environment do
    client = Langchain::Vectorsearch::Pgvector.new(                               
      url: ENV['DATABASE_URL'],                                                                             
      index_name: 'highlights',                                                                       
      llm: Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_KEY']),                                          
      namespace: 'openai'                                                                              
    )                                                                                                   

    conn = PG.connect(ENV['DATABASE_URL'])
    res = conn.exec("SELECT * FROM highlights WHERE vectors IS NULL")

    highlight_text = []                                                                             
    highlight_id = []  

    res.each do |row|
      metadata = row.except("highlight", "id", "created_at", "updated_at").compact.map do |key, value|
        "#{key}: #{value}"
      end.join("\n")

      greymatter = "---\n#{metadata}\n---\n#{row['highlight']}"

      highlight_text.push(greymatter) 
      highlight_id.push(row['id'])
    end
     
    client.upsert_texts(texts: highlight_text, ids: highlight_id)   
  end
end

