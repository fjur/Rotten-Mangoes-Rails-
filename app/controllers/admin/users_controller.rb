class Admin::UsersController < ApplicationController

  before_filter :check_if_admin

  def show
    @user = User.find(params[:id])
  end

  def new
    # binding.pry
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def check_if_admin
    if !current_user || current_user.admin == 0
      flash[:alert] = "You are not an admin"
      redirect_to movies_path
    end
  end

  protected

 def user_params
   params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
 end


end
