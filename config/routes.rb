Rails.application.routes.draw do
  get 'pages/add_item'
  post 'dish/add_to_cycle'
  post 'dish/add_to_temp'
  get 'dish/add_to_temporary_menu'
  get 'menu', to: 'menu#menu'
  get 'menu/:date', to: 'menu#new_date'
  
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
