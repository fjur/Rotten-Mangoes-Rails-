class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # def admin_user
  #   @admin_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  def preview_mode
    @preview_user ||= User.find(session[:super_user_id]) if session[:super_user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def switch_user
    temp = session
  end


  helper_method :current_user, :preview_mode


end
