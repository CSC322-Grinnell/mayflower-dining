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

Finally, assets/ folder contains static filer and css style sheets.

These are the main pieces of the app: request hits the routes, goes to controllers, they ask models for data,
and render the view.

## Database ##

Here is a diagram of the current database.

![alt text](./db-image.png "Current State of the DB")

Here is a detailed explanation of each table and its content.

### 1. Dishes ###
Has the dishes. Each dish should only appear once in here. Has a one to many relationship with entires in dishes_menus.
1. id: dish id. Auto-incremented.
2. name: dish name.
3. star: 0-3. 0 for no star. 1 for \*. 2 for \*\*. 3 for \*/\*\*.
4. mesh_soft: 0-2. 0 for none. 1 for Flaked. 2 for Ground.
5. puree: number of puree servings and puree texture.
6. portion_size: portion size of the dish.
7. diet: portion size for diet.
### 2. Dishes_Menus ###
Each entry contains information for one dish on one certain day / menu (0 - 48).
1. id: dish_menu id. Auto-incremented.
2. dish_id: the dish whose information is contained in this entry.
3. day: the index of the menu (0-48).
4. hc_prep: the prepared amount for dining location hc.
5. hc_leftover: the leftover amount for dining location hc.
6. hc_prep: the prepared amount for dining location hc.
5. hc_leftover: the leftover amount for dining location hc.
4. hc_prep: the prepared amount for dining location hc.
5. hc_leftover: the leftover amount for dining location hc.

## Models ##

The models directly interact with the DB and implement CRUD for all of them + some extra stuff.
### 1. Dish ###
CRUD:
1. Create: use add_dish. It accepts a name and list. The list should have elements of the following format: \[ingredient_name, portion_size, comment\]. The add_dish function will make the appropriate recipe entries using this list for a dish.
2. Read: use get_dish. Only works by name. Raises an exception if the dish with that name does not exist.
3. Update: you can only update a dish's name here by using update_name. For updating the recipes, resort to the recipes model. Can raise an exception if the dish you specified to update does not exist.
4. Destroy: use remove_dish. Automatically deletes all the recipes that depend on this dish, then deletes the dish. Raises an exception if the dish you specified does not exist or there is a menu connection with this dish in it (meaning you have to first remove this dish from menus before being able to delete the dish just for caution).

For adding a dish to a menu, look at the menu model.

TODO for the dishes model: ensure that you cannot make two dishes with the same name, or if you want to be able to do so, find a way to distinguish the two similar dishes.

### 2. Ingredient ###
CRUD:
1. Create: use add_ingredient.
2. Read: use get_ingredient.
3. Update: none.
4. Destroy: use remove_ingredient. It will raise an exception if there is a recipe that depends on it.

TODO for the ingredients model: understand how the MayFlower ingredient system actually works so you populate the relevant fields properly, do data validation, etc.
### 3. Menu ###
Note that all methods in the menu will be validated by day and type. Day has to be between 1 & 49 and type has to be either Breakfast, Dinner, or Supper. If validation fails, an exception will rise.
1. Create: You should not need to create more menus, they should be all created via the seed (the 49 day cycle should not be changed).
2. Read: For getting a menu, use get_menu.
3. Update: A menu should not need to be updated.
4. Remove: A menu itself should not deleted.

The menu model also handles adding, getting, and removing dishes to a menu. Getting and removing will raise an exception if the dish is not

1. Add: the dishes you wish to add should be created before calling these methods. You can also specify if the addition is permanent or not.
    1. For adding a single dish, use add_dish_to_cycle.
    2. For adding more than one dish, use add_dishes_to_cycle.
2. Get:
  1. For getting dishes of a menu by day and type, use get_dishes_by_day_type (day as in day in the cycle).
  2. For getting dishes of a menu by date and type, use get_dishes_by_date_type (date is in the format YYYY-mm-dd).
3. Remove: For removing a dish from a menu, use remove_dish_by_day_type. You can specify whether the removal is temporary or not.


TODO for the menu model: prevent a dish from being added to a menu more than once.


### 4. Recipe ###
CRUD:
1. Create: use create_recipe.
2. Read: use get_recipe_by_dish to get all the recipes belonging to a dish and get_recipe_by_ingredient to get all the recipes belonging to an ingredient.
3. Update: use update_dish for updating the dish of a recipe. Use update_ingredient for updating the ingredient of a recipe.
4. Destroy: we weren't able to hone this part. For instance, what would happen to recipe steps if one of them got removed? Should removal of single recipes be allowed?

TODO for the recipe model: figure out removal procedures.

### 5. Dishes_Menus ###
CRUD: This model does not have any CRUD mainly due to historical reasons. Initially, the connection between was established in the menu model without the help of this table. After adding this table, we didn't bother with moving the methods from the menu model to the dishes_menus model. You may do so if you would like.

Other methods:
1. clean_up: this method removes temporary changes. It destroys dish-menu connections that are temp==true and for connections that have show==false, it sets show=true.

## Controllers, routes and view ##

We aimed at being as concise as possible in terms of the number of views that we have, in order to prevent the user
from having to browse through multiple pages to do one thing. Therefore, the idea is that the menu.html.erb file
is used to display menu for any date, as well as add/remove dishes to the menu, and possibly create new dishes and ingredients.

Menu controller has two functions: one displays the menu for a given date, and another one edits the menu.
Dishes controller contains endpoints that create/update/destroy existing dishes.
Ingredients controller contains endpoints that create/update/destroy existing ingredients.

So as much logic as possible is dealt with on the front end of the main page to avoid creating too many unnecessary views. We were hoping to be sending post requests from the menu page to the controllers above, so that everything is managed from one page. We didn't exactly finish the full implementation of that, so its on you.

## Setup ##

Open up the file config/database.yml. It contains the information about what database setup needs to be in place
for your development environment. So you need to create a postgresql database, name it mayflower_dev, and set username and password as specified in the file. For Mac users, it is recommended to use pgadmin4 to manage database easily.

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

1. Finish hooking up the menu page to the controllers properly (there are a number of bugs and errors right now).
2. Creating to-do lists for the recipes.
3. Figure out how to deal with ingredients.
4. Connect recipe to do list to ingredient inventory.
5. Add a page for users to edit dishes and ingredients.
6. Add special menus: Thanksgiving, 4th of July, etc.
