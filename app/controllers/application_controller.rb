# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :can_edit?
  helper_method :admin_user?

  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end

  def current_user
    return unless session[:user_id].present?

    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def admin_user?
    true
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end

  def can_edit?(resource = nil)
    return true
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # TODO: fix this!!!!!!!!!!!!!!!!!!!!!!!!!!!

    user = current_user
    user.present? && (user.admin? || user.id == resource&.owner_id)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
