# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  def index
    @users = User.find(params[:user_id]).followers.order(:id).page(params[:page])
  end
end
