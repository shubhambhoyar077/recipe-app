class ShoppingListsController < ApplicationController
  def generate
    @recipes = current_user.recipe.includes(:food)
    @missing_foods = {}
    @total_value = 0

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
      @total_value += missing_quantity * food.price
    end
  end
end
