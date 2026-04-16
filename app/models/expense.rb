class Expense < ApplicationRecord
  belongs_to :user

  enum :category, {   housing: 0,
  food: 1,
  transport: 2,
  entertainment: 3,
  utilities: 4,
  shopping: 5,
  health: 6,
  other: 7
}

  validates :title, :category, :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
