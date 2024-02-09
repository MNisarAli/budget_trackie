class ExpensesController < ApplicationController
  before_action :set_category, only: %i[new create]

  def new
    @expense = @category.expenses.build
  end

  def create
    @expense = @category.expenses.build(expense_params)
    @expense.author = current_user

    if @expense.save
      flash[:notice] = 'Expense added successfully'
      redirect_to user_category_path(@category.user, @category)
    else
      flash[:alert] = 'Error creating the expense'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    if @expense.destroy
      flash[:notice] = 'Expense has been successfully removed'
    else
      flash[:alert] = 'Error deleting expense'
    end

    redirect_to request.referrer || user_categories_path
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
