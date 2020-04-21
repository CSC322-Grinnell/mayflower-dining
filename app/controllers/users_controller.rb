class UsersController < ApplicationController
  before_action :authenticate_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_user.admin && @user.save
      flash[:success] = 'Welcome!'
      redirect_to user_management_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(email: params[:user][:email], password: params[:user][:password],
                 password_confirmation: params[:user][:password_confirmation],
                 name: params[:user][:name], admin: params[:user][:admin])
    redirect_to user_management_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_management_path
  end

  def admin
  end

  def management
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :admin)
  end
end
