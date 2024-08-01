# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    if params[:admin] == 'true'
      render :admin_new
    elsif params[:vendor] == 'true'
      render :vendor_new
    else
      render :fan_new
    end
  end

  def create
    @user = User.find_or_initialize_by(identifier: params[:identifier])

    case params[:user_type]
    when 'fan'
      handle_fan_login
    when 'admin'
      handle_admin_login
    when 'vendor'
      handle_vendor_login
    else
      redirect_back(fallback_location: login_path, alert: 'Invalid login')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def handle_fan_login
    if @user.new_record?
      @user.role = 'attendee'
      @user.password = SecureRandom.hex(16)
      @user.save!
    end
    login_success("Logged in as fan: #{@user.identifier}")
  end

  def handle_admin_login
    if @user.persisted? && @user.admin? && @user.authenticate(params[:password])
      login_success("Logged in as admin: #{@user.identifier}")
    else
      login_failure('Invalid admin credentials')
    end
  end

  def handle_vendor_login
    if @user.new_record?
      if params[:password].present?
        @user.password = params[:password]
        @user.role = 'vendor'
        @user.save!
        @vendor = Vendor.create!(owner_id: @user.id, category: params[:category], name: params[:name])
        login_success("Vendor account created and logged in as: #{@user.identifier}")
      else
        login_failure('Password is required for new vendor accounts')
      end
    elsif @user.authenticate(params[:password])
      login_success("Logged in as vendor: #{@user.identifier}")
    else
      login_failure('Invalid vendor credentials')
    end
  end

  def login_success(message)
    session[:user_id] = @user.id
    if @user.vendor?
      redirect_to edit_vendor_path(@vendor), notice: message
    else
      redirect_to root_path, notice: message
    end
  end

  def login_failure(message)
    flash.now[:alert] = message

    case params[:user_type]
    when 'fan'
      render :fan_new
    when 'admin'
      render :admin_new
    when 'vendor'
      render :vendor_new
    else
      render :fan_new
    end
  end
end
