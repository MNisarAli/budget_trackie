require 'rails_helper'

RSpec.feature 'Expenses', type: :feature do
  before :each do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')
    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
    @expense = Expense.create(name: 'Pizza', amount: 10, author: @user, category_ids: [@category.id])

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'New page' do
    before do
      click_link 'Food'
      click_link 'Add New Expense'
    end

    it 'Displays the heading' do
      expect(page).to have_content('NEW EXPENSE')
    end

    it 'Creates a new expense' do
      fill_in 'Name', with: 'Pizza'
      fill_in 'Amount', with: 10
      check 'Food'
      click_button 'Add Expense'

      expect(page).to have_content('Expense added successfully')
    end
  end
end
