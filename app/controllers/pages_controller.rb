class PagesController < ApplicationController
    before_action :authenticate_user!
  def home
    @expenses      = (current_user.admin? ? Expense.all      : current_user.expenses).order(date: :desc)
    @subscriptions = (current_user.admin? ? Subscription.all : current_user.subscriptions).order(start_date: :desc)
    @budget = current_user.budget || current_user.build_budget
    @budget_amount = @budget.amount
    @yearly_expenses = @expenses.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:amount)
    @active_subscriptions_sum = @subscriptions.active.sum(:amount)
    @combined_total = @yearly_expenses + @active_subscriptions_sum
    @monthly_expenses = @expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @monthly_expenses_sum = @monthly_expenses.sum(:amount)
    @budget_percentage = @monthly_expenses_sum / @budget_amount * 100
    @monthly_subscription_sum = @subscriptions.active.where(billing_cycle: :monthly).sum(:amount)
  end
end
