class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @foods = current_user.food
  end

  def new
    @food = current_user.food.build
  end

  def create
    @food = current_user.food.build(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food Created!!'
    else
      @errors = @food.errors.full_messages
      render :new, alert: @errors
    end
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to foods_path, notice: "Deleted Food: #{food.name}"
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
