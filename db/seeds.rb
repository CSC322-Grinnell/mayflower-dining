# Create admin user
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?

# Import the csv table and remove all blank rows
table = CSV.parse(File.read("db/menus/cycle1.csv"), headers: true, skip_blanks: true) \
  .delete_if { |row| row.to_hash.values.all?(&:blank?) }

day = 1
row = 0

while row < table.length
  # Each day ends on "CYCLE: xxx"
  while !table[row][0].include? "CYCLE"
    type = "Dinner" # default type
    name = table[row][0]
    if name.start_with?("*")
      type = "Supper"
      name = name[1..-1]
    elsif name.start_with?("**")
      type = "Dinner"
      name = name[2..-1]
    end
    dish = Dish.create({name: name})
    Menu.add_dish_to_cycle(day, type, dish)

    # Add the id for the newly created dish
    row += 1
  end

  day += 1
  # Skip two rows: "CYCLE: xxx" and another header
  row += 2
end
