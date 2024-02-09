require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')
  end

  it 'should be associated to expenses' do
    expect(@user).to respond_to(:expenses)
  end

  it 'should be associated to categories' do
    expect(@user).to respond_to(:categories)
  end

  it 'is not valid without a name' do
    @user.name = ''
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = ''
    expect(@user).to_not be_valid
  end

  it 'is not valid with duplicate email' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'is not valid without a password' do
    @user.password = ''
    expect(@user).to_not be_valid
  end

  it 'is not valid with password length less than 6 char' do
    @user.password = 'x' * 5
    expect(@user).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
end
