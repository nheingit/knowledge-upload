class CsvController < ApplicationController
  def import
    user_id = current_user.id

    # Save the uploaded file to a temporary location
    tmp_file_path = Rails.root.join('tmp', "upload_#{Time.now.to_i}.csv")
    File.open(tmp_file_path, 'wb') do |file|
      file.write(params[:file].read)
    end

    # Enqueue the Sidekiq job
    job_id = CsvProcessorWorker.perform_async(tmp_file_path.to_s, user_id)
    redirect_to dashboard_path(job_id: job_id), notice: 'CSV is being processed...'
  end

end
