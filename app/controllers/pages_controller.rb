class PagesController < ApplicationController
    before_action :authenticate_user!
  def home
    @expenses      = (current_user.admin? ? Expense.all      : current_user.expenses).order(date: :desc)
    @subscriptions = (current_user.admin? ? Subscription.all : current_user.subscriptions).order(start_date: :desc)
    @budget = current_user.budget || current_user.build_budget

    @monthly_budget = @budget.amount
    @monthly_expenses = @expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @monthly_expenses_sum = @monthly_expenses.sum(:amount)
    @monthly_subscription_sum = @subscriptions.active.where(billing_cycle: :monthly).sum(:amount)
    @budget_percentage = @monthly_budget.present? ? (@monthly_expenses_sum + @monthly_subscription_sum) / @monthly_budget * 100 : 0
    @savings = @monthly_budget.present? ? @monthly_budget - (@monthly_expenses_sum + @monthly_subscription_sum) : 0
    @daily_limit = @savings / (Date.today.end_of_month.day - Date.today.day)

    @yearly_expenses = @expenses.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:amount)
    @active_subscriptions_sum = @subscriptions.active.sum(:amount)
    @combined_total = @yearly_expenses + @active_subscriptions_sum
  end
end
