# Create admin user
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?

Ingredient.create({name: "Ingredient one"})
Ingredient.create({name: "Ingredient two"})
Ingredient.create({name: "Ingredient three"})
Ingredient.create({name: "Ingredient four"})

d1 = Dish.create({name:"Dish one"})
d2 = Dish.create({name:"Dish two"})
d3 = Dish.create({name:"Dish three"})

Recipe.create({dish_id:1,ingredient_id:1})
Recipe.create({dish_id:1,ingredient_id:3})

Recipe.create({dish_id:2,ingredient_id:2})
Recipe.create({dish_id:2,ingredient_id:4})

Recipe.create({dish_id:3,ingredient_id:3})
Recipe.create({dish_id:3,ingredient_id:4})

Menu.create({day: 1, type_of_meal: "Dinner"})
Menu.create({day: 1, type_of_meal: "Supper"})

DishMenu.create({dish_id:1,menu_id:1})
DishMenu.create({dish_id:2,menu_id:1})

DishMenu.create({dish_id:2,menu_id:2})
DishMenu.create({dish_id:3,menu_id:2})