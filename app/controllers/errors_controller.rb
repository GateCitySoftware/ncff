class ErrorsController < ApplicationController
  skip_before_action :require_admin
  layout false

  def not_found
    # Handle 404 errors
  end

  def internal_server_error
    # Handle 500 errors
  end
end
