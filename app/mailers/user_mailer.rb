# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def login_link(user)
    @user = user
    @url = auth_url(token: @user.login_token)
    mail(to: @user.email, subject: 'Your login link')
  end
end
