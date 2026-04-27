class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update, :destroy, :confirm_destroy ]
  before_action :authenticate_user!
  def index
    @expenses      = (current_user.admin? ? Expense.all : current_user.expenses).order(date: :desc)
    @monthly_expenses = @expenses.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @monthly_expenses_sum = @monthly_expenses.sum(:amount)

    @monthly_expenses         = @monthly_expenses.where(category: params[:category]) if params[:category].present?
    @monthly_expenses         = @monthly_expenses.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
  end

  def history
    @expenses = (current_user.admin? ? Expense.all : current_user.expenses).order(date: :desc)
    @months = @expenses.unscope(:order).select("DATE_TRUNC('month', date) AS month").distinct.order(Arel.sql("DATE_TRUNC('month', date) DESC"))

    if params[:month].present?
      date = Date.parse(params[:month])
      @expenses = @expenses.where(date: date.beginning_of_month..date.end_of_month)
    end
    @expenses_sum = @expenses.sum(:amount)
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

  def confirm_destroy
  end

  private

  def set_expense
    @expense = current_user.admin? ? Expense.find(params[:id]) : current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :amount, :category, :date)
  end
end
