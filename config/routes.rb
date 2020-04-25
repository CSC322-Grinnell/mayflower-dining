Rails.application.routes.draw do
#--------------------------------------- menu
  # api to edit the menu (add dish, delete dish)
  get 'menu/edit/(:date/:acts/:dish/:type/:permanent)', to: 'menu#edit'
  # show menu(w/ buttons to delete/add dishes). date = optional parameter.
  # If none specified, uses current date
  get 'menu/(:date)', to: 'menu#menu'

#--------------------------------------- dishes
#   api to edit the dish
  post 'dishes/edit', to: 'dishes#edit'

#   api new dish
  post 'dishes/new', to: 'dishes#new'

#   api to delete a dish and its occurences from the db
  delete 'dishes/:name', to: 'dishes#delete'

# api to get all dishes
  get 'dishes/all', to: 'dishes#all'

#--------------------------------------- sessions
# logging in and logging out
  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  
#--------------------------------------- users
  resources :users
  get '/admin', to: 'users#admin', as: :admin
  get '/admin/management', to: 'users#management', as: :user_management

#---------------------------------------
  root to: "menu#menu"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
