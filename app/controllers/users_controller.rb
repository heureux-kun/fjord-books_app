class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.page(params[:page]).per(5).order('updated_at DESC')
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render 'edit'
    else
      redirect_to user_paths
    end
  end

  def update
    if @user.update(user_rarams)
      format.html { redirect_to @book, notice: t('devise.registrations.updated') }
    else
      format.html { render :edit }
    end
  end
end
