# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    session[:user_id] = User.find_or_create_by(identifier: params[:identifier])

    if user.persisted?
      redirect_to root_path, notice: 'Logged in successfully'
    else
      redirect_to root_path, notice: 'Account created and logged in successfully'
    end
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
