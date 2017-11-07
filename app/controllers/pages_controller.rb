class PagesController < ApplicationController

  def home
    if user_signed_in?
      @tweet = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    end
  end

  def profile
# grab the username from the URL as :id
    if  User.find_by_username(params[:id])
      @username = User.find_by_username(params[:id]) # this is to find a User by his/her username(which is unique because of our database validations) using User ID, which is unique by default(database behaviour).
     # this is to change the User ID(which is a number) into a instance variable @username.
                              # so now whatever we type after /user/ will be overwritten as the NEW ID(which was supposed to be a number previously) will be treated as @username. We can use @username wherever we want in the profile viewpage.
# using a built-in identifier for grabbing URL parameters. URL paramter :id and since we specified id in the routes as whatever comes after users, rails routing system will know that it is going to look for users. If users exist, whatever after that will be the user id.
    else
      # redirect to 404 (root for now)
      redirect_to root_path, :alert => "User not found!"  # notice: "User not found!" will also work.
    end
    @tweets = Tweet.all.where("user_id = ?", User.find_by_username(params[:id]).id )
# give us all the tweets, however give us them conditionally, we don't want any that don't belong to the user.
    @newtweet = Tweet.new
  end

  def users
    @all_other_users = User.where.not id: current_user.id
  end

end
