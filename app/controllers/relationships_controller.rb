class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by params[:followed_id]
    if @user
      current_user.follow(user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to user
    end
  end

  def destroy
    user = Relationship.find_by params[:id]).followed
    if @user
      current_user.unfollow(user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to user
    end
  end
end
