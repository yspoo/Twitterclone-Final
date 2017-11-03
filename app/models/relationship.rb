class Relationship < ApplicationRecord # Relationship is our join table.
  belongs_to :follower, class_name: "User"  # A "follower" is a User who clicks "follow" and follows other Users. It corresponds to the "follower_id" foreign key specified in the User model.
  belongs_to :followed, class_name: "User"  # A "followed" is a User who does not click "follow". He is followed by other Users. It corresponds to the "followed_id" foreign key specified in the User model.

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

# Model can only use:
# column names
# associations
