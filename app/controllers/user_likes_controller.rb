#-----------------------------------
# UserLikes: create, index, destroy
#-----------------------------------
class UserLikesController < ApplicationController
  before_action :authenticate_user

  def create
    process_like(params[:id], params[:liked])
  rescue => e
    logger.warn(e)
    render json: { error: 'Something went wrong' }, status: 422
  end

  def index
    @liked_users = current_user.liked_users
  end

  private

  def process_like(id, liked)
    if liked
      user_like = current_user.user_likes.find_or_create_by(liked_user_id: id)
      raise ArgumentError unless user_like.persisted?
      render json: { id: id, liked: true }, status: 200
    else
      UserLike.where(liked_user_id: id).destroy_all
      render json: { id: id, liked: false }, status: 200
    end
  end
end
