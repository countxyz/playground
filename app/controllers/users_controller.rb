class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      signin @user
      redirect_to profile_url, notice: 'Sign up successful'
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    redirect_to signin_url unless current_user
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
