class RelationshipsController < ApplicationController

  def create
    if user = User.find(params[:followed_id]) # find the user who is going to be followed.
      current_user.follow(user)
    else
      redirect_to :back # redirect to the current page.
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed  # find the pair of the two users and then getting the user who is being followed from that pair.
    current_user.unfollow(user)
    redirect_to :back
  end

end
