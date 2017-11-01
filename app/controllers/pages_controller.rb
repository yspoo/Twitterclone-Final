class PagesController < ApplicationController
  def index
  end

  def home
    @tweets = Tweet.all
  end

  def profile
# grab the username from the URL as :id
    if User.find_by_username(params[:username123]) # this is to find a User by his/her username(which is unique because of our database validations) using User ID, which is unique by default(database behaviour).
      @username = params[:username123] # this is to change the User ID(which is a number) into a instance variable @username.
                              # so now whatever we type after /user/ will be overwritten as the NEW ID(which was supposed to be a number previously) will be treated as @username. We can use @username wherever we want in the profile viewpage.
# using a built-in identifier for grabbing URL parameters. URL paramter :id and since we specified id in the routes as whatever comes after users, rails routing system will know that it is going to look for users. If users exist, whatever after that will be the user id.
    else
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!"
    end
    @tweets = Tweet.all.where("user_id = ?", User.find_by_username(params[:username123]).id )
# give us all the tweets, however give us them conditionally, we don't want any that don't belong to the user.
  end

  def users
    @users = User.all
  end
end
