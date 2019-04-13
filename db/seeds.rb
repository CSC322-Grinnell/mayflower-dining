# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?

# declaring ingredients and dishes for testing
ingredients = Ingredient.create([{name: 'flour'}, {name: 'sugar'}, {name: 'butter'}, {name: 'carrots'}, {name: 'spinach'}, 
	{name: 'apple'}, {name: 'chicken'}, {name: 'beef'}, {name: 'eggs'}, {name: 'salt'}, {name: 'pepper'}, {name: 'cinnamon'}])
dishes = Dish.create([{name: 'spaghetti'}, {name: 'salad'}, {name: 'cereal'}, {name: 'eggs'}, {name: 'lasagna'},
	{name: 'pizza'}, {name: 'steak'}, {name: 'potatoes'}, {name: 'risotto'}, {name: 'sandwich'}, {name: 'hamburger'}])

#seeding the database with random dishes and ingredient pairs
seed = Random.new
x = 1
while x < 50
# 	m = Menu.create(day: x)
	d = dishes[seed.rand(11)].dup
	d.ingredients.append(ingredients[seed.rand(11)])
# 	m.dishes.append(d)
    Menu.add_dishes_to_cycle(x, [d])
	x = x+1
end