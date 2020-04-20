class ApplicationController < ActionController::Base

  private
  def not_authenticated
    flash[:warning] = 'You have to be Mayflower Staff to access this page.'
    redirect_to log_in_path
  end
end
