class LogsController < ApplicationController
  def index
    @page = params[:page].to_i
    hash = HTTParty.get("http://localhost:3000/logs?page=#{@page}").parsed_response
    @logs = hash['logs']
    @count = hash['count']
    @pages = (@count / 5.0).ceil - 1
  end
end
