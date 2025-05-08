class RenameAmountToIncomeInBudgetItems < ActiveRecord::Migration[8.0]
  def change
    rename_column :budget_items, :amount, :income
  end
end
