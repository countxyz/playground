class SessionsController < ApplicationController

  def create
    user = User.find_by_email params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      signin user
      redirect_to profile_url, notice: 'Welcome Back!'
    else
      flash.now[:alert] = 'Unsuccessful Sign In'
      render 'new'
    end
  end

  def destroy
    signout
    redirect_to root_url, notice: 'Come back now, ya hear!'
  end
end
