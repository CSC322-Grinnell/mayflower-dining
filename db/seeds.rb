require 'csv'
# Create admin user
begin
  if Rails.env.development? or Rails.env.test?
    admin = User.new
    admin.email = "admin@example.com"
    admin.password = "password"
    admin.password_confirmation = "password"
    admin.name = "Mayflower Admin"
    admin.admin = true
    admin.save

    staff = User.new
    staff.email = "staff@example.com"
    staff.password = "password"
    staff.password_confirmation = "password"
    staff.name = "Mayflower Staff"
    staff.admin = false
    staff.save
  end
rescue => e
  puts "Users already created"
end

kMenuDir = 'db/menus/'

day = 0

Dir.foreach(kMenuDir) do |filename|
  next if filename == '.' or filename == '..'

  table = CSV.parse(File.read(kMenuDir + filename), headers: true, skip_blanks: true) \
    .delete_if { |row| row.to_hash.values.all?(&:blank?) }

  row = 0
  while row < table.length
    # Each day ends on "CYCLE: xxx"
    while !table[row][0].include? "CYCLE"
      # star options: 0 none, 1 *, 2 **, 3 */**
      type = 0 # default type
      name = table[row][0]
      if name.start_with?("*/**")
        type = 3
      elsif name.start_with?("**")
        type = 2
      elsif name.start_with?("*")
        type = 1
      end

      # Replace any leading non-word character with empty space
      name = name.sub!(/^\W*/, '')

      if !Dish.exists?(name: name)
        portion=table[row][1]
        ms=0
        meshsoft=table[row][2] # meshsoft options: 0 none, 1 flaked, 2 ground
        if meshsoft=="Flaked"
          ms=1
        elsif meshsoft=="Ground"
          ms=2
        end
        puree=table[row][3]
        diet=table[row][4]
        dish = Dish.create({name: name, star: type, mesh_soft:ms, puree:puree, portion_size:portion, diet:diet})
      else
        dish = Dish.find_by(name: name)
      end
      DishMenu.add_dish_to_cycle(day,dish.name)

      # Add the id for the newly created dish
      row += 1

    end

    day += 1
    # Skip two rows: "CYCLE: xxx" and another header
    row += 2

  end


end
