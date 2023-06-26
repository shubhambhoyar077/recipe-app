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

  def create
    @recipe = current_user.recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe is successfully Created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def destroy

  # end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end
end
