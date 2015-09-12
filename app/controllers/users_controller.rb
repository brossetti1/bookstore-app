class UsersController < ApplicationController
  before_action :require_signin, only: [:index, :show]
  before_action :require_admin, only: [:index, :show]
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User has been created'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'User has not been created'
      render :new
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
