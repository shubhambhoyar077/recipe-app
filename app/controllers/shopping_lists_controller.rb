class ShoppingListsController < ApplicationController
  def generate
    @recipes = current_user.recipe.includes(:food)
    @missing_foods = {}

    @recipes.each do |recipe|
      recipe.recipe_food.each do |recipe_food|
        food = recipe_food.food
        total_quantity = recipe_food.quantity

        if @missing_foods[food].nil?
          @missing_foods[food] = total_quantity
        else
          @missing_foods[food] += total_quantity
        end
      end
    end

    @missing_foods.each do |food, quantity|
      food_quantity = food.quantity
      missing_quantity = quantity - food_quantity
      @missing_foods[food] = missing_quantity
    end
  end
  
    # Should show the list of food that is missing for all recipes of the logged-in user 
    # (compare the list of food for all recipes with the general food list of that user).
    # Should count the total food items and total price of the missing food.

  # end
end
