class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @prompts = current_user.prompts.all.order(created_at: :asc)
  end
end
