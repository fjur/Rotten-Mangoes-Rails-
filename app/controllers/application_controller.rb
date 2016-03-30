class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # def admin_user
  #   @admin_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  def admin_id
    User.find(session[:admin_id])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user


end
