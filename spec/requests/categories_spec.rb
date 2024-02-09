require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password')

    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }

    @category = Category.create(name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png', user: @user)
  end

  describe 'GET /index' do
    before do
      get user_categories_path(@user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Categories')
    end
  end

  describe 'GET /new' do
    before do
      get new_user_category_path(@user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('New Category')
    end
  end

  describe 'POST /create' do
    before do
      post user_categories_path(@user), params: { category: { name: 'Food', icon: 'https://img.icons8.com/ios/50/000000/food.png' } }
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(user_categories_path(@user))
    end

    it 'includes the correct flash message' do
      follow_redirect!
      expect(response.body).to include('Category added successfully')
    end
  end

  describe 'GET /show' do
    before do
      get user_category_path(@user, @category)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Food')
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete user_category_path(@user, @category)
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(user_categories_path(@user))
    end

    it 'includes the correct flash message' do
      follow_redirect!
      expect(response.body).to include('Category has been successfully removed')
    end
  end

  describe 'DELETE /destroy with associated expenses' do
    before do
      @expense = Expense.create(name: 'Pizza', amount: 10, author: @user, category_ids: [@category.id])
      delete user_category_path(@user, @category)
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(user_categories_path(@user))
    end

    it 'includes the correct flash message' do
      follow_redirect!
      expect(response.body).to include('Error deleting category, it has associated expenses')
    end
  end
end
