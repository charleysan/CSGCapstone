class BudgetItem < ApplicationRecord
  belongs_to :user

  # Validations for the fields (optional but recommended)
  validates :category, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :spent, numericality: { greater_than_or_equal_to: 0 }
end
