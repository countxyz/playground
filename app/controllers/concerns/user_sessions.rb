module UserSessions
  extend ActiveSupport::Concern

  included do
    helper_method :admins_only
    helper_method :authorize_admin!
    helper_method :current_user
    helper_method :require_signin!
    helper_method :signed_in?
    helper_method :signin
    helper_method :signout
  end

  private

  def admins_only &block
    block.call if current_user.try :admin?
  end

  def authorize_admin!
    require_signin!

    unless current_user.try :admin?
      flash[:alert] = "Check ya' self before ya' wreck yo' self; Admins only!"
      redirect_to dashboard_url
    end
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def require_signin!
    if current_user.nil?
      flash[:error] = 'Sign In Required!'
      redirect_to signin_url
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def signin user
    session[:user_id] = user.id
  end

  def signout
    session.delete :user_id
    @current_user = nil
  end
end
