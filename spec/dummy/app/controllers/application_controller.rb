class ApplicationController < ActionController::Base
  include Userstamp::ControllerConcern

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    User.find(session[:user_id])
  end
end
