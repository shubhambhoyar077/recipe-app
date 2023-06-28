require 'rails_helper'

describe User, type: :model do
  before :each do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
  end

  it 'User model field should be equal to test user' do
    expect(@user.name).to eq('Test')
    expect(@user.email).to eq('test2@example.com')
    expect(@user.password).to eq('password')
  end
end
