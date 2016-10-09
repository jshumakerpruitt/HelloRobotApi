#----------------------------------------
# UsersController: all actions are require token auth
# except create (e.g. signin) and verify (i.e. use verification link)
#----------------------------------------
class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create, :verify, :random]

  # rubocop:disable Style/AccessorMethodName
  def get_current_user
    render json: { user: current_user.id }, status: 200
  end
  # rubocop:enable Style/AccessorMethodName

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

  # rubocop:disable Metrics/MethodLength
  def index
    query = <<-SQL
    SELECT users.id
    , users.username
    , users.avatar
    , users.age
    , users.gender
    , user_likes.user_id as liked
    FROM users
    LEFT OUTER JOIN user_likes
    ON users.id = user_likes.liked_user_id
    WHERE (user_likes.user_id = #{User.connection.quote(current_user.id)}
    OR user_likes.user_id IS NULL)
    SQL

    query += filter_string
    @users = User.find_by_sql(query)
  end
  # rubocop:enable Metrics/MethodLength

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
      render json: {error: 'could not process token'}
    end
  end

  def destroy
    @user = current_user.destroy
    render json: {message: 'account deleted'}
  rescue
    render json: {error: 'unable to delete account'}, status: 422
  end

  private
  def user_params
    params.require(:user).permit(:gender, :username, :password, :age, :email)
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def filter_string
    if params['gender']
      gender = "gender = #{User.connection.quote(params['gender'])}\n"
    end

    if params['minAge']
      min = Integer(params['minAge'])
      min_age = "age > #{User.connection.quote(min)}\n"
    end

    if params['maxAge']
      max = Integer(params['maxAge'])
      max_age = "age < #{User.connection.quote(max)}\n"
    end

    return ['', gender, min_age, max_age].compact.join('AND ')
  rescue StandardError => e
    logger.warn(e)
    return ''
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
