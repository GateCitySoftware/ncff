# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                      :uuid             not null, primary key
#  email                   :string
#  login_token             :string
#  login_token_valid_until :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  role                    :string           default("attendee"), not null
#  identifier              :string           not null
#  password_digest         :string
#
class User < ApplicationRecord
  ROLES = %w[attendee vendor admin].freeze

  validates :identifier, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }
  validate :valid_identifier

  has_secure_password

  def owner?(resource = nil)
    current_user.admin? || current_user.id == resource&.owner_id
  end

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

  def admin?
    role == 'admin'
  end

  def vendor?
    role == 'vendor'
  end

  def fan?
    role == 'attendee'
  end

  private

  def valid_identifier
    email_regex = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
    phone_regex = /\A(\+1|1)?[-.\s]?\(?[2-9]\d{2}\)?[-.\s]?\d{3}[-.\s]?\d{4}\z/

    return if identifier&.match?(email_regex) || identifier&.match?(phone_regex)

    errors.add(:base, 'Must enter a valid email or phone number')
  end
end
