# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_admin

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
      if @user.new_record?
        @user.role = 'attendee'
        @user.password = SecureRandom.hex(16)
        @user.save!
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in as fan: #{@user.identifier}"
      elsif @user.fan?
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in as fan: #{@user.identifier}"
      elsif @user.vendor?
        flash.now[:alert] = 'This is an Vendor account, password is required.'
        render :vendor_new
      elsif @user.admin?
        flash.now[:alert] = 'This is an Admin account, password is required.'
        render :admin_new
      end
    when 'admin'
      if @user.persisted? && @user.admin? && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in as admin: #{@user.identifier}"
      else
        flash.now[:alert] = 'Invalid admin credentials'
        render :admin_new
      end
    when 'vendor'
      if @user.new_record?
        if params[:password].present?
          @user.password = params[:password]
          @user.role = 'vendor'
          @user.save!
          @vendor = Vendor.create!(owner_id: @user.id, category: params[:category], name: params[:name],
                                   approved: false)
          session[:user_id] = @user.id
          redirect_to edit_vendor_path(@vendor), notice: "Vendor account created and logged in as: #{@user.identifier}"
        else
          flash.now[:alert] = 'Password is required for new vendor accounts'
          render :vendor_new
        end
      elsif @user.vendor? && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to edit_vendor_path(@user.vendor_record), notice: "Logged in as vendor: #{@user.identifier}"
      elsif @user.admin?
        flash.now[:alert] = 'This is an Admin account, please login here.'
        render :admin_new
      else
        flash.now[:alert] = 'Invalid vendor credentials'
        render :vendor_new
      end
    else
      redirect_back(fallback_location: login_path, alert: 'Invalid login')
    end
  rescue StandardError => e
    redirect_back(fallback_location: login_path, alert: e)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
