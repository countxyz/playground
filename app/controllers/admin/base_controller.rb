class Admin::BaseController < ApplicationController
  include UserSessions
  before_action :authorize_admin!
end
