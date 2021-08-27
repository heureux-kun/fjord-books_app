class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
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
    
    respond_to do |format|
      if @user.update(user_rarams)
        format.html { redirect_to @book, notice: t('devise.registrations.updated')}
        format.html{ redirect_to @user, notice: t('') }
        format.json{ render :show, status: :ok, location: @user }
      else
        format.html{ render :edit }
        format.json{ render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
