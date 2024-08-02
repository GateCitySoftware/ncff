# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  layout 'application'

  before_action :gon_current_user

  helper_method :current_user
  helper_method :uuid?

  def gon_current_user
    gon.current_user_id = current_user&.id
  end

  private

  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
