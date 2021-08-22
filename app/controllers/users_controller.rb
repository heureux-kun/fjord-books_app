class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:zip, :address, :profile)
  end
end
