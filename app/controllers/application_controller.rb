# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  layout 'application'
  rescue_from StandardError, with: :handle_error

  before_action :gon_global_data
  before_action :require_admin
  before_action :set_paper_trail_whodunnit

  helper_method :current_user
  helper_method :uuid?

  def gon_global_data
    gon.current_user_id = current_user&.id
    gon.flash = flash
  end

  private

  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_admin
    return if current_user&.admin?

    redirect_to root_path, alert: 'You must be an admin to access this page.'
  end

  def handle_error
    Rails.logger.error "ApplicationController Rescued Error: #{exception.message}"

    # Send error to Bugsnag with custom metadata
    Bugsnag.notify(exception) do |report|
      report.add_metadata(:custom, {
                            user_id: current_user&.id
                          })
    end

    flash[:error] = 'Something went wrong, please try again. Our engineers have been notified.'
    redirect_to root_path
  end
end
