class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  def index
    @expenses = current_user.admin? ? Expense.all : current_user.expenses
    @subscriptions = current_user.admin? ? Subscription.all : current_user.subscriptions
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
