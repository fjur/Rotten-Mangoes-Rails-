class Admin::UsersController < ApplicationController

  before_filter :check_if_admin

  def show
    @user = User.find(params[:id])
  end

  def new
    # binding.pry
    @user = User.new
  end

  def debug
    # binding.pry
    session[:super_user_id] = current_user.id
    session[:user_id] = params[:user_id]
    redirect_to movies_path
  end

  def exit_debug
    session[:user_id] = session[:super_user_id]
    session[:super_user_id] = nil
    redirect_to admin_users_path
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
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
