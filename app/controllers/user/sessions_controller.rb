class User::SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def new
    redirect_to root_path if admin_signed_in?
  end

  def create
    @user = User.find_by_email(params[:user][:email].downcase)
    if @user
      if @user.authenticate(params[:user][:password])
        login @user
        remember(@user) if params[:user][:remember_me] == "1"
        redirect_to root_path, notice: 'Signed in.'
      else
        flash.now[:alert] = 'Incorrect password.'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Incorrect email'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user) if cookies[:remember_token].present?
    logout
    redirect_to root_path, notice: 'Signed out.'
  end
end
