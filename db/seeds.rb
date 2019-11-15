# Create admin user
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?

# Import the csv table and remove all blank rows
Dir.foreach('db/menus/') do |filename|
  next if filename == '.' or filename == '..'

  table = CSV.parse(File.read(filename), headers: true, skip_blanks: true) \
    .delete_if { |row| row.to_hash.values.all?(&:blank?) }
  
  day = 1
  row = 0
  
  while row < table.length
    dishes = Array.new

    # Assume the dish that does not start with either "*" or "**" is a dinner dish
    type = "Dinner"   

    # Each day ends on "CYCLE: xxx"
    while !table[row][0].include? "CYCLE" 
      name = table[row][0]
      if name.start_with?("*")
        name = name[1..-1] 
        type = "Dinner"
      elsif name.start_with?("**")
        name = name[2..-1]
        type = "Supper"
      end

      d = Dish.create({name: name})
      # Add the id for the newly created dish
      dishes.push(d)
      row += 1
    end
  
    Menu.add_dishes_to_cycle(day, type, dish_ids)

    day += 1
    # Skip two rows: "CYCLE: xxx" and another header
    row += 2
  end
end
