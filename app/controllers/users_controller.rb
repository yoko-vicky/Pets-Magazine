class UsersController < ApplicationController
  before_action :require_login, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]
  before_action only: %i[edit update destroy] do
    require_same_user(@user)
  end

  def index
    @users = User.all
  end

  def show
    @articles = @user.ordered_articles.includes(:author)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "#{@user.name} was successfully created and logged in"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{@user.name} was successfully updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    flash[:notice] = "#{@user.name} was successfully deleted and logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
