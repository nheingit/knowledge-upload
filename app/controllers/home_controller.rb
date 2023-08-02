class HomeController < ApplicationController
  def index
    @prompts = Prompt.all.order(created_at: :asc)
  end
end
