class PromptsController < ApplicationController
  def create
    @input = params[:prompt]
    client = Langchain::Vectorsearch::Pgvector.new(                               
      url: ENV['DATABASE_URL'],                                                                             
      index_name: 'highlights',                                                                       
      llm: Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_KEY']),                                          
      namespace: 'openai'                                                                              
    )                                                                                                   
    @response = client.ask(question: @input)

    @prompt = current_user.prompts.create(input: @input, response: @response)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to prompts_path, flash: { scroll_to_bottom: true } }
    end
  end
end

def documents_model
  Class.new(Sequel::Model(table_name.to_sym)) do
    plugin :pgvector, :vectors
  end
end
