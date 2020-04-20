class UsersController < ApplicationController
  before_action :authenticate_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_user.admin && @user.save
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def admin
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :admin)
  end
end
