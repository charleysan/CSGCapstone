class MakeUserIdNotNullInTasksAndBudgetItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tasks, :user_id, false
    change_column_null :budget_items, :user_id, false
  end
end
