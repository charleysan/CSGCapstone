class AddSpentToBudgetItems < ActiveRecord::Migration[8.0]
  def change
    add_column :budget_items, :spent, :decimal
  end
end
