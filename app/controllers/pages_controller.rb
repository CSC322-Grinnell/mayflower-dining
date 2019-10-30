class PagesController < ApplicationController
  before_action :authenticate_user!, except:[:home]

  # home page
  def home
  end
  
  # add_item page
  def add_item
  end
end