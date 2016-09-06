class UserLikesController < ApplicationController
  before_action :authenticate_user
  def create
    id = params['like'] && params['like']['id']
    if current_user.user_likes.create(liked_user_id: id)
      render json: {"status": 201}, status: 201
    end
  end

  def index
    @liked_users = current_user.liked_users
  end
end
