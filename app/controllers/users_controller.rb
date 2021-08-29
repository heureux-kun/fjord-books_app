# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user.update user_params
  end

  private

  def user_params
    params.require(:user).permit(:image)
  end
end
