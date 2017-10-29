class PagesController < ApplicationController
  def index
  end

  def home
  end

  def profile
    # grab the username from the URL as :id
    if (User.find_by_username(params[:id]))
    @username = params[:id]
# using a built-in identifier for grabbing URL parameters. URL paramter :id and since we specified id in the routes as whatever comes after users, rails routing system will know that it is going to look for users. If users exist, whatever after that will be the user id.
    else
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!"
  end

  def explore
  end
end
