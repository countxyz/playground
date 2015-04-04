class SessionsController < ApplicationController

  def create
    user = User.find_by_email params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      signin user
      redirect_to profile_url, notice: 'Welcome Back!'
    else
      flash.now[:alert] = 'Unsuccessful login'
      render 'new'
    end
  end
end
