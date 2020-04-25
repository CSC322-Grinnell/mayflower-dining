class Dish < ApplicationRecord
    validates :name, presence: true
    validates :star, :inclusion => 0..3
    validates :mesh_soft, :inclusion => 0..2

    def self.get_dish(query)
        if query.is_a? Integer
            dish = self.where(id:query)
        elsif query.is_a? String
            dish = self.where(name:query)
        else
            raise ArgumentError, "Query can only be dish id or dish name."
        end
        raise ArgumentError, "Dish #{name} doesn't exist." unless !dish.empty?
        dish.first
    end

    def self.add_dish(name:, star:0, mesh_soft:0, puree:"", portion_size:"", diet:"")
        dish = self.where(name:name)
        raise ArgumentError, "Dish already exists. Use update_dish." unless dish.empty?
        self.create!({name:name, star:star, mesh_soft:mesh_soft, puree:puree, portion_size:portion_size, diet:diet})
    end

    # updates a dishes name
    # validates input
    def self.update_dish(name:, new_name:nil, star:nil, mesh_soft:nil, puree:nil, portion_size:nil, diet:nil)
        dish = self.get_dish(name)
        dish.name = (new_name == nil ? dish.name : new_name)
        dish.star = (star == nil ? dish.star : star)
        dish.mesh_soft = (mesh_soft == nil ? dish.mesh_soft : mesh_soft)
        dish.puree = (puree == nil ? dish.puree : puree)
        dish.portion_size = (portion_size == nil ? dish.portion_size : portion_size)
        dish.diet = (diet== nil ? dish.diet : diet)
        dish.save
        dish
    end

    # destroy a dish based on name
    # also destroys its recipes
    def self.remove_dish(name)
        dish = self.get_dish(name)
        raise ArgumentError, "Dependent menu exist. Remove from menu before removing from dishes." \
            unless not DishMenu.exists?(dish_id:dish.id)
                # destroy dish
                dish.destroy
                dish
        end
    end
