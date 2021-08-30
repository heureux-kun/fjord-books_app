# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    super
    if account_update_params[:image].present?
      resource.image.attach(account_update_params[:image])
    end
  end

  private
    def user_params
      params.require(:user).permit(:image)
    end
end
