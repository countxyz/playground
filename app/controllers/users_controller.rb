class UsersController < ApplicationController
  before_action :set_user, only: %i(show dashboard)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      signin @user
      redirect_to dashboard_url, notice: 'Sign up successful'
    else
      flash.now[:alert] = 'Sign up unsuccessful'
      render 'new'
    end
  end

  def dashboard
    redirect_to signin_url unless @user
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end

  def set_user
    @user = current_user
  end
end
