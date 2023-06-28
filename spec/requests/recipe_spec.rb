require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
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

  # describe 'GET /users/:id' do
  #   before :all do
  #     @new_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.')
  #   end
  #   it 'should responce with success.' do
  #     get user_url(@new_user)
  #     expect(response).to have_http_status(:success)
  #   end
  #   it 'should responce with correct status' do
  #     get user_url(@new_user)
  #     expect(response.status).to eq(200)
  #   end
  #   it 'should render correct template' do
  #     get user_url(@new_user)
  #     expect(response).to render_template('show')
  #   end
  # end
end