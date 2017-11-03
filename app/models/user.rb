class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tweets, dependent: :destroy # removes the user's posts if his account is deleted.
  has_many :active_relationships, class_name:   "Relationship",  #  active_relationships is going to correspond with the Relationships model
                                  foreign_key:  "follower_id",   #  follower_id is the ID of the user who clicks on "follow".
                                  dependent:    :destroy         #  when user deletes his account, other people's account will have 1 less follower.
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",   # followed_id is the ID of the user who gets followed by other Users.
                                   dependent: :destroy           # when user deletes his account, other people's account will have 1 less following.
 has_many :following, through: :active_relationships, source: :followed
 has_many :followers, through: :passive_relationships, source: :follower
=begin
By default, Rails will act like:
  has_many :followed, through: :active_relationships
  has_many :follower, through: :passive_relationships
=> Rails will have a default source. In this case, the source is the column name that we specified in Relationship model, which is "followed". However, if we change "followed" to "banana", then the source also changes to "banana".

However, if we prefer to have our own naming, we can write it like:
  has_many :following, through: :active_relationships, source: :followed
  has_many :follower, through: :passive_relationships, source: :followed
=> Now, we can use <user>.following to find all the people that <user> followed. We have to specify the "source" to the column we are linking to. So if "followed" was changed to "banana", then the source also changes to "banana".

 "following" and "followers" can be any names I want.
 It is just a naming convention for a helper method so that we can use:
  <user>.following to find all the people that <user> followed.
  <user>.followers to find all the people that follows <user>.
=end

 scope :latest, -> {order(created_at: :desc) }

 # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4}, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 } # device gem also has password validation - length: { minumum: 6 }
end
