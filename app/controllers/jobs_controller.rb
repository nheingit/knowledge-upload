class JobsController < ApplicationController
  def progress
    job_id = params[:job_id]
    status = Sidekiq::Status::complete?(job_id) ? 'complete' : 'in_progress'
    message = Sidekiq::Status::get(job_id, :message)
    progress = Sidekiq::Status::get(job_id, :progress).to_i

    render json: { status: status, message: message, progress: progress }
  end
end
