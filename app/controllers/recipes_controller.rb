class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  # def create

  # end

  # def destroy

  # end
end
