class CreateBudgetItems < ActiveRecord::Migration[8.0]
  def change
    create_table :budget_items do |t|
      t.string :title
      t.decimal :amount
      t.string :category
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
