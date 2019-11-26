Rails.application.routes.draw do
  #resources :dishes
  #resources :ingredients
#--------------------------------------- menu

  # show menu(w/ buttons to delete/add dishes). date = optional parameter. 
  # If none specified, uses current date
  get 'menu/(:date)', to: 'menu#menu'

  # api to edit the menu (add dish, delete dish)
  post 'menu/edit/(:week/:day)', to: 'menu#edit'


#--------------------------------------- dishes
#   api to edit the dish
  post 'dishes/edit', to: 'dishes#edit'

#   api new dish
  post 'dishes/new', to: 'dishes#new'

#   api to delete a dish and its occurences from the db
  delete 'dishes/:name', to: 'dishes#delete'


#--------------------------------------- ingredients 

# api to edit the ingredient name/total_amount
 post 'ingredients/edit/', to: 'ingredients#edit'

# api to make new ingredient for a dish
 post 'ingredients/new', to: 'ingredients#new'

# api to delete the ingredient and all its occurences
 delete 'ingredients/:name', to: 'ingredients#delete'

  
  root to: "menu#menu"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


