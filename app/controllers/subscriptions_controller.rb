class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @subscription = current_user.subscriptions.new
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to root_path
  end

  private

  def set_subscription
    @subscription = current_user.admin? ? Subscription.find(params[:id]) : current_user.subscriptions.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:title, :amount, :billing_cycle, :start_date, :status)
  end
end
