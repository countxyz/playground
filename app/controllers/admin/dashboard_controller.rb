class Admin::DashboardController < ApplicationController
  before_action :authorize_admin!

  def dashboard; end
end
