class Budget < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }, if: :enabled?
end
