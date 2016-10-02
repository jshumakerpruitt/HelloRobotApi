#----------------------------------------
# UsersController: all actions are require token auth
# except create (e.g. signin) and verify (i.e. use verification link)
#----------------------------------------
class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create, :verify, :random]

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer
        .signup(@user.email, @user.to_valid_token)
        .deliver_now
      render json: { status: 'created' }, status: 201
    else
      logger.warn("Signup Error: #{@user.errors.full_messages}")
      render json: { errors: @user.errors }, status: 422
    end
  end

  # rubocop:disable Metrics/LineLength
  def index
    @users = User.select('users.id, users.username, users.avatar, users.age, users.gender, user_likes.user_id as liked')
                 .joins('LEFT OUTER JOIN user_likes on users.id = user_likes.liked_user_id')
                 .where('user_likes.user_id = ? OR user_likes.user_id IS NULL', current_user.id)
  end
  # rubocop:enable Metrics/LineLength

  def random
    @users = User.select(:username, :id).limit(16).order('RANDOM()')
    render json:  @users
  end

  def show
    @user = User.find(params[:id])
  end

  def logout_all
    current_user.logout_all
    render json: { info: 'success' }
  end

  def verify
    user = User.verify_from_token params['token']
    if user
      render json: { jwt: user.to_valid_token }
    else
      render json: {}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender, :username, :password, :age, :email)
  end
end
