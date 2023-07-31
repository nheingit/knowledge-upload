require 'csv'

class CsvController < ApplicationController
  def import
    Highlight.import(params[:file], current_user)
    redirect_to root_url, notice: 'CSV imported successfully.'
  end
end

