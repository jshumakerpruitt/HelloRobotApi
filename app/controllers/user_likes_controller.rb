class UserLikesController < ApplicationController
  before_action :authenticate_user
  def create
    id = params['id']
    user_like = current_user.user_likes.create!(liked_user_id: id)
    if user_like.save
      render json: {"id": id, "liked": true}, status: 201
    else
      render json: user_like.errors.full_messages, status: 404
    end
  end

  def destroy
    id = params['id']
    user_like = current_user.user_likes.where(liked_user_id: id).first
    if user_like
      user_like.destroy
      render json: {"id": id, "liked": false}, status: 200
    else
      render json: {}, status: 404
    end
  end

  def index
    @liked_users = current_user.liked_users
  end
end
