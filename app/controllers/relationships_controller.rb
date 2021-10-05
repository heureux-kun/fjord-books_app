# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    # @userだけで@user.idが入る
    if current_user.follow(@user)
      # ユーザーをフォローした時のメッセージ
      flash[:notice] = t('controllers.common.notice_create', name: Relationship.human_attribute_name(:following))
    else
      # ユーザーのフォローに失敗した時のメッセージ
      flash[:alert] = t('controllers.common.notice_failed_to_create', name: Relationship.human_attribute_name(:following))
    end
    redirect_to user_path(@user)
    # redirect_to user_path(@user), succness: 'ユーザーをフォローしました' という書き方もある
  end

  def destroy
    if current_user.unfollow(@user)
      # ユーザーのフォローを解除した時のメッセージ
      flash[:notice] = t('controllers.common.notice_destroy', name: Relationship.human_attribute_name(:following))
    else
      # ユーザーのフォロー解除に失敗した時のメッセージ
      flash[:alert] = t('controllers.common.notice_railed_to_destroy', name: Relationship.human_attribute_name(:following))
    end

    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
