class Subscription < ApplicationRecord
  belongs_to :user

  enum :billing_cycle, { weekly: 0, monthly: 1, yearly: 2 }
  enum :status, { active: 0, paused: 1, cancelled: 2 }

  validates :title, :billing_cycle, :start_date, :status, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
