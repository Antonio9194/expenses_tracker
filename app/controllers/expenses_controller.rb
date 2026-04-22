class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  def index
    all_expenses      = (current_user.admin? ? Expense.all      : current_user.expenses).order(date: :desc)
    all_subscriptions = (current_user.admin? ? Subscription.all : current_user.subscriptions.order(date: :desc))

    # Stats always use the full unfiltered collections
    @yearly_expenses = all_expenses.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:amount)
    @active_subscriptions_total = all_subscriptions.active.sum(:amount)
    @combined_total           = @yearly_expenses + @active_subscriptions_total
    @monthly_expenses         = all_expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:amount)
    @monthly_expenses_record  = all_expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month).order(date: :desc)
    @monthly_subscription     = all_subscriptions.active.where(billing_cycle: :monthly).sum(:amount)
    @expense_count            = all_expenses.count

    # Apply filters only for the table display
    @expenses      = all_expenses
    @subscriptions = all_subscriptions
    @expenses      = @expenses.where(category: params[:category])           if params[:category].present?
    @subscriptions = @subscriptions.where(billing_cycle: params[:billing_cycle]) if params[:billing_cycle].present?
    @subscriptions = @subscriptions.where(status: params[:status])          if params[:status].present?
  end

  def show
  end

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      redirect_to expenses_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path
  end

  private

  def set_expense
    @expense = current_user.admin? ? Expense.find(params[:id]) : current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :amount, :category, :date)
  end
end
