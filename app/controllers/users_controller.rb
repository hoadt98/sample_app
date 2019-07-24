class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, only: %i(show edit update destroy)

  def index
    @users = User.page(params[:page]).per Settings.paginate_per
  end

  def show
    @user = User.find_by params[:id]
    @microposts = @user.microposts.page(params[:page]).per Settings.paginate_per
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "create"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "updated"
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

  def following
    @title = t "following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = t "followers"
    @user  = User.find_by params[:id]
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  def follow
    @form = current_user.active_relationships.build
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
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
      flash[:none] = t "none"
      redirect_to root_path
    end
end
