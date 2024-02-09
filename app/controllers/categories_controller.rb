class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]

  def index
    @user = current_user
    @categories = @user.categories.order(created_at: :desc)
    @expenses = current_user.expenses
  end

  def show
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      flash[:notice] = 'Category added successfully'
      redirect_to user_categories_path
    else
      flash[:alert] = 'Please provide a valid category Name & Icon'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.expenses.empty?
      @category.destroy
      flash[:notice] = 'Category has been successfully removed'
    else
      flash[:alert] = 'Error deleting category, it has associated expenses'
    end

    redirect_to user_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
