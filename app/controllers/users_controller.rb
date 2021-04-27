class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @users = User.find(params[:id])
    @favorites = current_user.favorites.all
  end

  private
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end