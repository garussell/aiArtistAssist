module SessionsHelper
  def new_session(artist)
    session[:artist_id] = artist.id
  end

  # def current_session
  #   @_current_session ||= Artist.find_by(id: session[:artist_id])
  # end

  def log_out_artist
    session.delete(:artist_id)
    # @_current_session = nil
    reset_session
  end
end
