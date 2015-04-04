module UserSessions
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :signed_in?
    helper_method :signin
    helper_method :signout
  end

  private

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
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
