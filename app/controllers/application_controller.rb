class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  helper_method :current_session, :logged_in?
  include SessionsHelper

  # def current_session
  #   @_current_session ||= Artist.find_by(id: session[:artist_id])
  # end

  # def logged_in?
  #   !!current_session
  # end
end
