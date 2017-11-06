class TweetsController < ApplicationController

  before_action :find_tweet, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!



  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id  # assign the tweet to the user who created it.
    if @tweet.save
      respond_to do |f|
        f.html { redirect_to "", notice: "Tweet created!" }
      end
    else
      respond_to do |f|
        f.html { redirect_to "", alert: "Error: Post not saved!" }
      end
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def tweet_params  # allows certain data to be passed via form.
    params.require(:tweet).permit(:user_id, :content)
  end

  def find_tweet
  end

end
