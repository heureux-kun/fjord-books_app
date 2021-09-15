# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_image.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
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
