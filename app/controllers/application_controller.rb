class ApplicationController < ActionController::Base

  private
  def not_authenticated
    flash[:warning] = 'You have to be Mayflower Staff to access this page.'
    redirect_to log_in_path
  end

  def authenticate_admin
    unless current_user && current_user.admin
      flash[:warning] = "You must be an admin user to access this page."
      redirect_to log_in_path
    end
  end
end
