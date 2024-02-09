require 'rails_helper'

RSpec.describe Expense, type: :model do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')
    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
    @expense = Expense.create(name: 'Pizza', amount: 10, author: @user)
    @expense.categories << @category
  end

  it 'should be associated to an author' do
    expect(@expense).to respond_to(:author)
  end

  it 'should be associated to a user through author_id' do
    expect(@expense.author).to eq(@user)
  end

  it 'should be associated to a category' do
    expect(@expense).to respond_to(:categories)
  end

  it 'should be associated to a user through a category' do
    expect(@expense.categories.first.user).to eq(@user)
  end

  it 'is not valid without a name' do
    @expense.name = ''
    expect(@expense).to_not be_valid
  end

  it 'is not valid with name length more than 50 char' do
    @expense.name = 'x' * 51
    expect(@expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end

  it 'is not valid with non-numeric amount' do
    @expense.amount = 'test'
    expect(@expense).to_not be_valid
  end

  it 'is not valid with amount less than 1' do
    @expense.amount = 0
    expect(@expense).to_not be_valid
  end

  it 'is not valid without an author_id' do
    @expense.author_id = nil
    expect(@expense).to_not be_valid
  end

  it 'is not valid with an author_id that does not exist' do
    @expense.author_id = 999
    expect(@expense).to_not be_valid
  end

  it 'is not valid without a category' do
    @expense.categories = []
    expect(@expense).to_not be_valid
  end

  it 'is valid with multiple categories' do
    @expense.categories = [@category, Category.new(name: 'test', icon: 'test', user: @user)]
    expect(@expense).to be_valid
  end

  it 'is valid with valid attributes' do
    expect(@expense).to be_valid
  end
end
