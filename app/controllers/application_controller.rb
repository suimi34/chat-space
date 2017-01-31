class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    chat_groups_path
  end

  def after_sign_up_path_for(resource)
    chat_groups_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def all_users_without_current_user
    return User.joins(:chat_groups).where.not(users: { id: @chat_group.user_ids }).distinct
  end

  def chat_group_users
    return @chat_group.users.where.not(users: { id: current_user.id })
  end
end
