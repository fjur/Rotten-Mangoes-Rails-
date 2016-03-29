class Admin::UsersController < ApplicationController

  def show
    @users = User.all

    if !current_user || current_user.admin == 0
      flash[:alert] = "You are not an admin"
      redirect_to movies_path
    end

  end

end
