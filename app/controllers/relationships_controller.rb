# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    # @userだけで@user.idが入る
    if current_user.follow(@user)
      flash[:success] = 'ユーザーをフォローしました'
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
    end
    redirect_to user_path(@user)
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
    end

    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
