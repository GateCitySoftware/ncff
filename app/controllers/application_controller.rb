# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :uuid?

  private

  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    # remove this!
    return unless @current_user.nil?

    User.new.tap { |user| user.role = 'admin' }
  end
end
