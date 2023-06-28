require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  describe 'recipe show page' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      @recipe = Recipe.create(user: @user, name: "test recipe1", preparation_time: 1, cooking_time: 10, description: "test test1")
      @test_food = Food.create(user: @user, name: "test food", measurement_unit: 'unit', price: 10, quantity: 2)
      @recipe_food = RecipeFood.create(quantity: 10, food: @test_food, recipe: @recipe)
      visit generate_shopping_list_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
    it 'Shoping list content' do
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Food item to buy: 1')
      expect(page).to have_content("Total: $#{(@recipe_food.quantity * @test_food.price) - (@test_food.price * @test_food.quantity)}")
    end
  end
end