Rails.application.routes.draw do
  get 'pages/add_item'
  post 'dish/add_to_cycle'
  post 'dish/add_to_temp'
  get 'dish/add_to_temporary_menu'
  get 'menu', to: 'menu#menu'
  get 'menu/:date', to: 'menu#new_date'
  get 'permanent_edit', to: 'permanent_edit#permanent_edit'
  get 'permanent_edit/:id', to: 'permanent_edit#view_dishes'
  get '/edit_dish/:id', to: 'dish#show', as: 'dish'
  
  
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
