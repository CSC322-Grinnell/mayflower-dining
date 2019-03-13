Rails.application.routes.draw do
  get 'static_pages/add_item'
  post 'dish/add_to_cycle'
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
