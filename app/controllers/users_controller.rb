class UsersController < ApplicationController
  before_action :authenticate_user! && :correct_user, only: [:index, :show, :following, :followers]

  def index
    @users = User.paginate(page: params[:page], per_page: 10).latest
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(page: params[:page], per_page: 10).latest
  end

  def following
   @title = "Following"
   @user  = User.find(params[:id])
   @users = @user.following.paginate(page: params[:page])
  # render 'show_follow'
  end

  def followers
   @title = "Followers"
   @user  = User.find(params[:id])
   @users = @user.followers.paginate(page: params[:page])
  # render 'show_follow'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def prepare_followee
  @followee = User.find(params[:id])
  end

  def avatar_url
    params.require(:avatar_url)
  end
  
end
