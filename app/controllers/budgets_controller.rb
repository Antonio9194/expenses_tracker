class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [ :edit, :update, :toggle ]

  def new
    @budget = current_user.build_budget
  end

  def create
    @budget = current_user.build_budget(budget_params)
    if @budget.save
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  def toggle
    @budget.enabled = !@budget.enabled
    @budget.save(validate: false)
    redirect_to root_path
  end

  private

  def budget_params
    params.require(:budget).permit(:amount, :enabled)
  end

  def set_budget
    @budget = current_user.budget || current_user.build_budget
  end
end
