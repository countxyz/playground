class SessionsController < ApplicationController

  def new
    redirect_to root_url if signed_in?
  end

  def create
    user = User.find_by_email params[:session][:email].downcase

    if user && user.activated_authentication?(params[:session][:password])
      signin user
      redirect_user
    else
      flash.now[:alert] = 'Unsuccessful Sign In'
      render 'new'
    end
  end

  def destroy
    signout
    redirect_to root_url, notice: 'Come back now, ya hear!'
  end

  private

  def redirect_user
    if current_user.try :admin?
      redirect_to admin_dashboard_url, notice: 'Welcome Back!'
    else
      redirect_to dashboard_url, notice: 'Welcome Back!'
    end
  end
end
