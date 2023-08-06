class PagesController < ApplicationController
  def dashboard
    def progress
      job_id = params[:job_id]
      status = Sidekiq::Status::Status(job_id)
      render json: { status: status }
    end
    if user_signed_in?
      @highlights = current_user.highlights.paginate(page: params[:page], per_page: 5)
    else
      @highlights = []
    end
  end
end
