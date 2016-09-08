class UsersController < ApplicationController
  before_action :authenticate_user, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      exp = Time.now.to_i + 3.hours
      token = Knock::AuthToken.new(payload: { sub: "#{@user.id}", exp: exp }).token
      UserMailer.signup(@user.email, token).deliver_now
      render json: {'status': 'created'}, status: 201
    else
      render json: {errors: @user.errors}
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def logout
   #manipulate passed token and return
  end

  def logout_all
    current_user.update_attribute(:token_timestamp, Time.now)
    render json: {info: "success" }
  end

  def verify
  end
  private
  def user_params
    params.require(:user).permit(:username, :password, :age, :email)
  end
end
