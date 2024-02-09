require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  before :each do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')
    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
    @expense = Expense.create(name: 'Pizza', amount: 10, author: @user, category_ids: [@category.id])

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'Index page' do
    it 'Displays the heading' do
      expect(page).to have_content('CATEGORIES')
    end

    it 'Displays list of all categories' do
      expect(page).to have_content('Food')
    end

    it 'Navigates to the category page' do
      click_link 'Food'

      expect(page).to have_current_path(user_category_path(@user, @category))
    end

    it 'Displays the button to delete a category' do
      click_button 'Delete'

      expect(page).to have_content('Error deleting category, it has associated expenses')
    end

    it 'Displays the button to add a new category' do
      click_link 'Add New Category'

      expect(page).to have_current_path(new_user_category_path(@user))
    end
  end

  describe 'New page' do
    before do
      click_link 'Add New Category'
    end

    it 'Displays the heading' do
      expect(page).to have_content('NEW CATEGORY')
    end

    it 'Creates a new category' do
      fill_in 'Name', with: 'Education'
      fill_in 'Icon', with: 'https://img.icons8.com/ios/50/000000/education.png'
      click_button 'Add Category'

      expect(page).to have_content('Category added successfully')
    end
  end

  describe 'Show page' do
    before do
      click_link 'Food'
    end

    it 'Displays the heading' do
      expect(page).to have_content('EXPENSES')
    end

    it 'Displays the button to add a new expense' do
      click_link 'Add New Expense'

      expect(page).to have_current_path(new_user_category_expense_path(@user, @category))
    end

    it 'Displays the button to delete an expense' do
      click_button 'Delete'

      expect(page).to have_content('Expense has been successfully removed')
    end
  end
end
