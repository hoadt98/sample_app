class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, only: %i(show edit update destroy)

  def index
    @users = User.page params[:page]
    User.paginates_per 10
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t"welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t"updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t"deleted"
      redirect_to users_url
    else
      render :index
    end
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      return if logged_in?
      flash[:danger] = t"login-not"
      redirect_to login_url
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:none] = t"none"
      redirect_to root_path
    end
end
