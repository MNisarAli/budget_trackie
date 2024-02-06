require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')
    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
  end

  it 'should be associated to a user' do
    expect(@category).to respond_to(:user)
  end

  it 'should be associated to a user through user_id' do
    expect(@category.user).to eq(@user)
  end

  it 'is not valid without a name' do
    @category.name = ''
    expect(@category).to_not be_valid
  end

  it 'is not valid with name length more than 50 char' do
    @category.name = 'x' * 51
    expect(@category).to_not be_valid
  end

  it 'is not valid without an icon' do
    @category.icon = ''
    expect(@category).to_not be_valid
  end

  it 'is not valid with icon length more than 300 char' do
    @category.icon = 'x' * 301
    expect(@category).to_not be_valid
  end

  it 'is not valid without a user_id' do
    @category.user_id = nil
    expect(@category).to_not be_valid
  end

  it 'is not valid with a user_id that does not exist' do
    @category.user_id = 999
    expect(@category).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(@category).to be_valid
  end
end
