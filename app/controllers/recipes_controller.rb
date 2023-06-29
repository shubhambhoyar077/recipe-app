class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def index
    @recipes = current_user.recipe
  end

  def show
    if user_signed_in?
      @recipe = Recipe.find(params[:id])
    else
      @recipe = Recipe.find(params[:id])
      if !@recipe.public
        redirect_to new_user_session_path
      end
    end
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

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      msg = 'Recipe is Private'
      msg = 'Recipe is Public' if @recipe.public
      redirect_to recipe_path(@recipe), notice: msg
    else
      redirect_to recipe_path(@recipe), alert: 'Someting is wrong'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path, status: :see_other
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end

end
