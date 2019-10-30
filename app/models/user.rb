class User < ApplicationRecord
  # Other available modules are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  #validates :email, presence: true, uniqueness: true
  
end
