class SessionsController < ApplicationController
  def login
    artist = Artist.find_by(email: params[:email])
    if artist && artist.authenticate(params[:password])
      new_session(artist)
      flash[:success] = "You have successfully logged in"
      redirect_to artist_path(artist)
    else
      flash[:warning] = "Invalid email or password"
      redirect_to root_path
    end
  end

  def logout
    message = "Your session has expired. Please login again." if params[:timeout].present?
    message = "You have successfully logged out" if params[:timeout].nil?
    
    log_out_artist
    flash[:info] = "You have successfully logged out"
    redirect_to root_path
  end
end
