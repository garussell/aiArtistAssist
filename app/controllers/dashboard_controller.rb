class DashboardController < ApplicationController
  def index
    @artist = Artist.find_by(id: session[:artist_id])
    @zen_statement = StatementsModule.random_zen_statement
  end
end