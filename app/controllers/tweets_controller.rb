class TweetsController < ApplicationController

  before_action :find_tweet, only: [:edit, :destroy]
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

  def destroy
    @tweet.destroy
    flash[:notice] = "Tweet deleted!"
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params  # allows certain data to be passed via tweet form.
    params.require(:tweet).permit(:user_id, :content)
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end

end
