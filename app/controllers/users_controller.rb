# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @user_image = User.all.includes(@user)
  end

  def update
    super
    user.image.attach(account_update_params[:image]) if account_update_params[:image].present?
  end

  private

  def user_params
    params.require(:user).permit(:image)
  end
end
