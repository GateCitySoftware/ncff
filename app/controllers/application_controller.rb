# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def uuid?(string)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    uuid_regex.match?(string)
  end
end
