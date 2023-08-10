class CsvController < ApplicationController
  def import
    user_id = current_user.id

    # Read the uploaded file and encode it as a Base64 string
    csv_content = params[:file].read
    encoded_csv_content = Base64.encode64(csv_content)


    # Enqueue the Sidekiq job
    job_id = CsvProcessorWorker.perform_async(encoded_csv_content, user_id)
    redirect_to dashboard_path(job_id: job_id), notice: 'CSV is being processed...'
  end

end
