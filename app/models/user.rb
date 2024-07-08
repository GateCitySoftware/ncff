# frozen_string_literal: true

class User < ApplicationRecord
  def generate_login_token
    self.login_token = SecureRandom.urlsafe_base64
    self.login_token_valid_until = 72.hours.from_now
    save
  end

  def login_token_valid?
    login_token_valid_until > Time.current
  end

  def clear_login_token
    update(login_token: nil, login_token_valid_until: nil)
  end
end
