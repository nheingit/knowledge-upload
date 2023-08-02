class HomeController < ApplicationController
  def index
    if user_signed_in?
      @highlights = current_user.highlights.paginate(page: params[:page], per_page: 5)
      highlight_texts = @highlights.map(&:to_greymatter)
      highlight_ids = @highlights.map(&:id)
      client = Langchain::Vectorsearch::Pgvector.new(
        url: 'postgres://postgres:iLVoD0s9P00HQUfO@db.odxmukmmhrjzstymqycf.supabase.co:6543/postgres',
        index_name: 'highlights',
        llm: Langchain::LLM::OpenAI.new(api_key: "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"),
        namespace: 'openai'
      )
      client.upsert_texts(texts: highlight_texts, ids: highlight_ids)
    else
      @highlights = []
    end
  end
end
