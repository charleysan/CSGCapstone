class BudgetItem < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :category, presence: true
  validates :date, presence: true
  validates :income, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :spent, numericality: { less_than_or_equal_to: 0 }, allow_nil: true
end
