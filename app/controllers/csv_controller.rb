require 'csv'

class CsvController < ApplicationController
  def import
    user_id = current_user.id
    Highlight.import(params[:file], user_id)
    redirect_to root_url, notice: 'CSV imported successfully.'
  end
end

