# README #

Hi folks! Current deployment: https://mayflower-dining-staging.herokuapp.com

##  Overview of the project files ##

We begin by looking over what lives where in our project.

Open up the file config/routes.rb: it contains the endpoints that
are exposed in our app.
They are divided into 3 logical components: menu, dishes and ingredients.
One the request hits one of those endpoints, it is passed to appropriate controller.

Go to app/ folder. You can find controllers/ directory there. It contains the code that decides
what happens with a given request: it talks to the database via Models and renders views.

In app/ folder, see models/ directory. It contains some of the functionality related to databases.
More on the schema will be later.

In app/ folder look at views/. It has one important view: menu/menu.html.erb. It is what is shown to the user.

Finally, assets/ folder contains static filer and css stylesheets.

These are the main pieces of the app: request hits the routes, goes to controllers, they ask models for data,
and render the view.

## Database ##

![alt text](./db-image.png "Current State of the DB")


Finally, the scheduled command that resets all temp changes to the menu is defined as the rake task here: lib/tasks/scheduled_db_commands.rake, and you should use heroku scheduler to run it in production. It required extra steps from the owner of the repo (professor), so we didn't add that. See: https://devcenter.heroku.com/articles/scheduler for how to set it up.
## Controllers, routes and view ##

We aimed at being as consice as possible in terms of the number of views that we have, in order to prevent the user
from having to browse through multiple pages to do one thing. Therefore, the idea is that the menu.html.erb file
is used to display menu for any date, as well as add/remove dishes to the menu, and possibly create new dishes and ingredients.

Menu controller has two functions: one displays the menu for a given date, and another one edits the menu.
Dishes controller contains endpoints that create/update/destroy existing dishes.
Ingredients controller contains endpoints that create/update/destroy existing ingredients.

So as much logic as possible is dealt with on the frontend of the main page to avoid creating too many unnecessary views. We were hoping to be sending post requests from the menu page to the controllers above, so that everything is managed from one page. We didn't exactly finish the full implementation of that, so its on you.

## Setup ##

Open up the file config/database.yml. It contains the information about what database setup needs to be in place
for your development environment. So you need to create a postgresql database, name it mayflower_dev, and set username and password as specified in the file. For Mac users, it is recomended to use pgadmin4 to manage database easily.

Then install gems by running

```
bundle install
```

Then seed the database with the data provided by Scott

```
rails db:seed
```

Then run the server

```
rails s
```


## Honorable mentions ##

Procfile is the file that runs release-setup.sh file everytime the app is pushed to Heroku. Then, you don't have to manually run migrations and seed on the database. Edit release-setup.sh, if you want other stuff to happen on deployment.

db/menus contains the tables of mayflower menu that Scott gave us. db:seed uses this data right now.

db/seeds.rb is what takes db/menus and sends that data to the database.

db/migrate contains migrations. NOTE: MIGRATIONS ARE APPEND ONLY. So, if you add anything to the database via migraitons, do not edit existing ones but create new file for each change you make. Otherwise, you will have incompatible migrations on different machines, and it means suffering.

## Deployments ##

The app is currently deployed to heroku.

Install heroku CLI: https://devcenter.heroku.com/articles/heroku-cli#download-and-install

```
heroku login
```

Then once you want to push the new feature to production, do

```
git push <Your heroku repo found under Settings on heroku dashboard> master
```

## Future work ##

Finish hooking up the menu page to the controllers (lots of javascript)
Creating to-do lists
Other things
