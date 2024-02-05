class CreateCategoriesExpensesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :categories, :expenses
  end
end
