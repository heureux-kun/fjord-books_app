# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).followings.order(:id).page(params[:page])
  end
end
