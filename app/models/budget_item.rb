class BudgetItem < ApplicationRecord
  validates :title, :amount, :category, :date, presence: true
end
