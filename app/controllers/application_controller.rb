class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  before_action :set_categories

  private

  def set_categories
    @categories = Category.select(:id, :name, :slug)
  end

  before_action :load_current_logo

  private

  def load_current_logo
    @current_logo = Logo.first
  end
end
