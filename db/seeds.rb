# Create admin user
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?

# Import the csv table and remove all blank rows
table = CSV.parse(File.read("db/menus/cycle1.csv"), headers: true, skip_blanks: true) \
  .delete_if { |row| row.to_hash.values.all?(&:blank?) }

day = 0
row = 0

while row < table.length
  dish_ids = Array.new

  # Each day ends on "CYCLE: xxx"
  while !table[row][0].include? "CYCLE"
    Dish.create({name: table[row][0]})
    # Add the id for the newly created dish
    dish_ids.push(Dish.count)
    row += 1
  end

  Menu.create({day: day, type_of_meal: "Dinner", dish_ids: dish_ids})
  day += 1
  # Skip two rows: "CYCLE: xxx" and another header
  row += 2
end
