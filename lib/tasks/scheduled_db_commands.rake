namespace :scheduled_db_commands do
  desc "Running the database clean up"
  task cleanup: :environment do
    DishMenu.remove_temp_changes
  end

end
