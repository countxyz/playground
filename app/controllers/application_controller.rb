class ApplicationController < ActionController::Base
  include UserSessions
  protect_from_forgery with: :exception
end
