class PagesController < ApplicationController
    before_action :authenticate_user!
  def home
    all_expenses      = (current_user.admin? ? Expense.all      : current_user.expenses).order(date: :desc)
    all_subscriptions = (current_user.admin? ? Subscription.all : current_user.subscriptions).order(start_date: :desc)

    # Stats always use the full unfiltered collections
    @yearly_expenses = all_expenses.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:amount)
    @active_subscriptions_total = all_subscriptions.active.sum(:amount)
    @combined_total           = @yearly_expenses + @active_subscriptions_total
    @monthly_expenses         = all_expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:amount)
    @monthly_expenses_record  = all_expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month).order(date: :desc)
    @monthly_subscription     = all_subscriptions.active.where(billing_cycle: :monthly).sum(:amount)
  end
end
