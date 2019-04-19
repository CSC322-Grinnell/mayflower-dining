Rails.application.routes.draw do
  get 'static_pages/add_item'
  post 'dish/add_to_cycle'
  get 'pages/menu'
  get 'menu', to: 'menu#menu'
  get 'menu/:date', to: 'menu#new_date'
  get 'prep/prep_page', to: 'prep#preppage'
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
