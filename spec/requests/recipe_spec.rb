require 'rails_helper'

RSpec.describe Recipe, type: :request do
  describe 'GET /recipes' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      sign_in @user
    end
    it 'should responce with success.' do
      get "/recipes"
      expect(response).to have_http_status(:success)
    end
    it 'should responce with correct status' do
      get "/recipes"
      expect(response.status).to eq(200)
    end
    it 'should render correct template' do
      get "/recipes"
      expect(response).to render_template('index')
    end
  end

  describe 'GET /recipes/:id' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      sign_in @user
      @recipe = Recipe.create(user: @user, name: "test recipe", preparation_time: 1, cooking_time: 10, description: "test test")
    end
    it 'should responce with success.' do
      get recipe_path(@recipe)
      expect(response).to have_http_status(:success)
    end
    it 'should responce with correct status' do
      get recipe_path(@recipe)
      expect(response.status).to eq(200)
    end
    it 'should render correct template' do
      get recipe_path(@recipe)
      expect(response).to render_template('show')
    end
    it 'should render correct template' do
      get recipe_path(@recipe)
      expect(response.body).to include('test recipe')
    end
  end

  describe 'POST :create' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      sign_in @user
    end
    it "creates a new recipe" do

      # Define the recipe attributes you want to create
      recipe_attributes = { name: "test recipe", preparation_time: 1, cooking_time: 10, description: "test test" }

      # Perform the POST request
      post :create, params: { recipe: recipe_attributes }

      # Assert that the recipe was created successfully
      expect(response).to have_http_status(:created)
      expect(Recipe.count).to eq(1)
      expect(Recipe.last.name).to eq("Test Recipe")
      expect(Recipe.last.description).to eq("Test description")
    end
    # it "creates a new recipe with success" do
    #   post :create, params: { recipe: { name: "test recipe", preparation_time: 1, cooking_time: 10, description: "test test" } }, path: recipes_path
    #   expect(response).to have_http_status(:success)
    # end

    # it "creates a new recipe and checking count" do
    #   expect {
    #     post :create, params: { recipe: { name: "test recipe", preparation_time: 1, cooking_time: 10, description: "test test" } }, path: recipes_path
    #   }.to change(Recipe, :count).by(1)
    # end

    # it "creates a new recipe with success" do
    #   post :create, params: { recipe: { name: "test recipe", preparation_time: 1, cooking_time: 10, description: "test test" } }, path: recipes_path
    #   expect(response.body).to include('test recipe')
    # end

    
  end
end