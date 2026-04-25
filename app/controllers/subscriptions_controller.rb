class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [ :show, :edit, :update, :destroy, :confirm_destroy ]
  before_action :authenticate_user!

  def index
    all_subscriptions = (current_user.admin? ? Subscription.all : current_user.subscriptions).order(start_date: :desc)

    @active_subscriptions_total = all_subscriptions.active.sum(:amount)
    @monthly_subscription     = all_subscriptions.active.where(billing_cycle: :monthly).sum(:amount)

    @subscriptions = all_subscriptions
    @subscriptions = @subscriptions.where(billing_cycle: params[:billing_cycle]) if params[:billing_cycle].present?
    @subscriptions = @subscriptions.where(status: params[:status]) if params[:status].present?
  end

  def show
  end

  def new
    @subscription = current_user.subscriptions.new
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to subscriptions_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to subscriptions_path
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to subscriptions_path
  end

  def confirm_destroy
  end

  private

  def set_subscription
    @subscription = current_user.admin? ? Subscription.find(params[:id]) : current_user.subscriptions.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:title, :amount, :billing_cycle, :start_date, :status)
  end
end
