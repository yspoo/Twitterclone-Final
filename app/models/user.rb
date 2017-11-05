class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
 has_many :tweets, dependent: :destroy # removes the user's posts if his account is deleted.
 has_many :active_relationships,  class_name:   "Relationship",  #  active_relationships is going to correspond with the Relationships model
                                  foreign_key:  "follower_id",   #  follower_id is the ID of the user who clicks on "follow".
                                  dependent:    :destroy         #  when user deletes his account, other people's account will have 1 less follower.
# Now, a current user is just able to have his ID(as a follower) in multiple records in the Relantionship database. However, he is not linked to anyone.
 has_many :following, through: :active_relationships, source: :followed   # now, the current user is able to follow many other different users.

 has_many :passive_relationships,  class_name:  "Relationship",
                                   foreign_key: "followed_id",   # followed_id is the ID of the user who gets followed by other Users.
                                   dependent: :destroy           # when user deletes his account, other people's account will have 1 less following.
# Now, a current user is just able to have his ID(as a followed) in multiple records in the Relationship database. However, he is not linked to anyone.
 has_many :followers, through: :passive_relationships, source: :follower  # now, the current user is able get followed by many other different users.

=begin
By default, Rails will act like:
  has_many :followed, through: :active_relationships            Because the current user clicks on the "follow" button to follow other users, he has many "followed" users.
  has_many :follower, through: :passive_relationships           Because the current user is getting followed by other users who clicks on the "follow" button, he has many
                                                                "follower" users.
=> Rails will have a default source. In this case, the source is the column name that we specified in Relationship model, which is "followed". However, if we change "followed" to "banana", then the source also changes to "banana". Now, we can use <user>.followed to find all the people that <user> followed.

However, if we prefer to have our own naming, we can write it like:
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :followed
=> Now, we can use <user>.following to find all the people that <user> followed. We have to specify the "source" to the column we are linking to. So if "followed" was changed to "banana", then the source also changes to "banana".

 "following" and "followers" are just names chosen. They are be any names you want. It is just a naming convention for a helper method so that we can use:
  <user>.following to find all the people that <user> followed.
  <user>.followers to find all the people that follows <user>.
=end

# Helper methods
  # The following and unfollowing actions from the perspective of the current user. "other" refers to other different users. I used passive_relationships as well to see if I understood the concept correctly. By using "passive_relationships", I can force other users to follow or unfollow the current user even if they did not click on the "follow"/"unfollow" buttons respectively.

  # Establishing a relationship. Can use either.
  def follow(other)
    active_relationships.create(followed_id: other.id)  # current user follows the user he wants to follow.
  end
  # active_relationships, by default, will input the current user ID as the follower ID. So when we use active_relationships.create => it only has to create the ID of the followed user as the followed ID.

  def getfollowedby(other)
    passive_relationships.create(follower_id: other.id) # current user gets followed by another user. That user would have clicked on the "follow" button for this to happen.
  end

  # Destroying a relationship. Can use either.
  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy # current user unfollows the user he wants to unfollow. We do not use follower_id because doing so will destroy all the relationships that current user has with other users as well.
  end

  def getunfollowedby(other)
    passive_relationships.find_by(follower_id: other.id).destroy # current user gets unfollowed by another user. That user would have clicked on the "unfollow" button for this to happen.
  end

  # Finding out if a relationship exists.
  def following?(other)
    following.include?(other.id) # Find out if current user is already following the user he is interested in. # Returns a Boolean true or Boolean false value.
  end

  def is_a_follower_of?(other)
    followers.include?(other.id) # Find out if current user is already a follower of the user he is interested in.
  end

  scope :latest, -> {order(created_at: :desc) }

 # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4}, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 } # device gem also has password validation - length: { minumum: 6 }
end
