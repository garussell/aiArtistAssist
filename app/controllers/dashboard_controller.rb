class DashboardController < ApplicationController
  def index
    @artist = Artist.find_by(id: session[:artist_id])
  end
end