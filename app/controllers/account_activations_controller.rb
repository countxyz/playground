class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by email: params[:email].downcase

    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      signin user
      redirect_to dashboard_url, notice: 'Account Activated!'
    else
      redirect_to root_url, alart: 'Invalid activation link'
    end
  end
end
