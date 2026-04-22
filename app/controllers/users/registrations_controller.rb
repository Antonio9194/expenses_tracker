class Users::RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def update_currency
    current_user.update(currency: params[:currency])
    redirect_back fallback_location: root_path
  end
end
