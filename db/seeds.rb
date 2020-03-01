# Create admin user
begin 
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?
rescue => e
  puts "Admin already created"
end 

kMenuDir = 'db/menus/'

day = 1

Dir.foreach(kMenuDir) do |filename|
  next if filename == '.' or filename == '..'

  table = CSV.parse(File.read(kMenuDir + filename), headers: true, skip_blanks: true) \
    .delete_if { |row| row.to_hash.values.all?(&:blank?) }

  row = 0
  while row < table.length
    # Each day ends on "CYCLE: xxx"
    while !table[row][0].include? "CYCLE"
      type = "Dinner" # default type
      name = table[row][0]
      if name.start_with?("*")
        type = "Supper"
      elsif name.start_with?("**")
        type = "Dinner"
      end
  
      # Replace any leading non-word character with empty space
      name = name.sub!(/^\W*/, '')
  
      if !Dish.exists?(name: name)
        dish = Dish.create({name: name})
      else
        dish = Dish.find_by(name: name)
      end
      Menu.add_dish_to_cycle(day, type, dish)
  
      # Add the id for the newly created dish
      row += 1

    end
  
    day += 1
    # Skip two rows: "CYCLE: xxx" and another header
    row += 2

  end


end

# Create Locations

Location.create!(name:"Dining Hall", population:1000)
Location.create!(name:"Cafeteria", population:10)
Location.create!(name:"Bar", population:50)

