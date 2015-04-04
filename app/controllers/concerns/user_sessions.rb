module UserSessions
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :signin_user
  end

  private

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def signin user
    session[:user_id] = user.id
  end
end
