class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_return_to, unless: :devise_controller?
  before_filter :set_search

  include SessionsHelper
  include UsersHelper
  include StaticPagesHelper
  include ApplicationHelper

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :phone, :role, :picture]
  end

  def logged_in_user
    unless user_signed_in?
      store_location
      flash[:danger] = t :log_in_require
      redirect_to login_url
    end
  end

  def stored_location_for resource_or_scope
    session[:user_return_to] || super
  end

  def store_return_to
    store_location_for :user, request.url
  end

  def set_search
    @q = Event.search params[:q]
  end
end
