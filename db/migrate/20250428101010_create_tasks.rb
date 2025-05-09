class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :completed
      t.string :category
      t.datetime :due_date

      t.timestamps
    end
  end
end
