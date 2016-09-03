class UsersController < ApplicationController
  before_action :authenticate_user, except: :create

  def new
    @user = User.new
  end

  def create
    puts user_params
    @user = User.new(user_params)
    if @user.save
      @users = User.all
      render json: {}
    else
      render json: @user.errors
    end
  end

  def index
    @users = User.all
    #render @users
    #render json: @users
  end

  private
  def user_params
    puts params
    params.require(:user).permit(:username, :password, :age, :email)
  end
end
