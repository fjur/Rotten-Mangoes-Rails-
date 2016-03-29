class Admin::UsersController < ApplicationController

  before_filter :check_if_admin

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def check_if_admin
    if !current_user || current_user.admin == 0
      flash[:alert] = "You are not an admin"
      redirect_to movies_path
    end
  end

end
