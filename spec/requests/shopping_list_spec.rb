require 'rails_helper'

RSpec.describe 'Shopping list', type: :request do
  describe 'GET /recipes' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      sign_in @user
    end
    it 'should responce with success.' do
      get generate_shopping_list_path
      expect(response).to have_http_status(:success)
    end
    it 'should responce with correct status' do
      get generate_shopping_list_path
      expect(response.status).to eq(200)
    end
    it 'should render correct template' do
      get generate_shopping_list_path
      expect(response).to render_template('generate')
    end
  end
end
