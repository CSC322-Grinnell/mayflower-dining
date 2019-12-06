
# This file runs the DishMenu.remove_temp_changes command 
# every day at night.
# This way, the database is cleaned from all temporary changes
# See DishMenu for more details


# NOTE: Heroku does not support cron jobs, which this gem runs.
# So in production use heroku scheduler to run rake task at /lib/tasks/scheduled_db_commands.rake
# It requires the credit card for the account, so we didn't do it. 
# See https://devcenter.heroku.com/articles/scheduler

every 1.day, at: '11:30 pm' do
  runner "DishMenu.remove_temp_changes"
end