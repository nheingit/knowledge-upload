class PagesController < ApplicationController
  def dashboard
    if user_signed_in?
      @highlights = current_user.highlights.paginate(page: params[:page], per_page: 5)
    else
      @highlights = []
    end
  end
end
