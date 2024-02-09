require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')

    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }

    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
    @expense = Expense.create(name: 'Pizza', amount: 10, author: @user, category_ids: [@category.id])
  end

  describe 'GET /new' do
    before do
      get new_user_category_expense_path(@user, @category)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('New Expense')
    end
  end

  describe 'POST /create' do
    before do
      post user_category_expenses_path(@user, @category),
           params: { expense: { name: 'Pizza', amount: 10, author: @user, category_ids: [@category.id] } }
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(user_category_path(@user, @category))
    end

    it 'includes the correct flash message' do
      follow_redirect!
      expect(response.body).to include('Expense added successfully')
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete user_category_expense_path(@user, @category, @expense)
    end

    it 'redirects to the categories page' do
      expect(response).to redirect_to(user_categories_path(@user))
    end

    it 'includes the correct flash message' do
      follow_redirect!
      expect(response.body).to include('Expense has been successfully removed')
    end
  end
end
