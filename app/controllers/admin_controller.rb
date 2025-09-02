class AdminController < ApplicationController
  before_action :authenticate_user!   # require login to see /admin

  def index; end
end
