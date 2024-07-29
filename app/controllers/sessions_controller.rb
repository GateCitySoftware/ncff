# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_or_create_by(email: params[:email])
    user.generate_login_token
    UserMailer.login_link(user).deliver_now
    redirect_to login_path, notice: 'Check your email for the login link.'
  end

  def auth
    user = User.find_by(login_token: params[:token])
    if user&.login_token_valid?
      session[:user_id] = user.id
      user.clear_login_token
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      redirect_to login_path
    end
  end

  def admin_auth
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
