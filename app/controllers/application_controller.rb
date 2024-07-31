# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :can_edit?
  helper_method :uuid?

  private

  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end

  def can_edit?(resource = nil)
    current_user.present? && (current_user.admin? || current_user.id == resource&.owner_id)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
