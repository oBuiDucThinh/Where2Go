class Admin::AdminController < ApplicationController
  layout "admin/application"
  before_action :logged_in_user, :is_admin?

  private

  def is_admin?
    return if current_user.admin?
    redirect_to error_path
  end
end
