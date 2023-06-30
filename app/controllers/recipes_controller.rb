class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show public]
  def index
    @recipes = current_user.recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
    return unless !user_signed_in? && !@recipe.public

    redirect_to new_user_session_path
  end

  def public
    @recipes = Recipe.includes(:user, :recipe_food).where(public: true).order(created_at: :desc)
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
