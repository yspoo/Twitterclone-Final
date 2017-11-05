class Relationship < ApplicationRecord # Relationship is our join table.
  belongs_to :follower, class_name: "User"  # A "follower" is a User who clicks "follow" and follows other Users. "class_name" is to link to the User model. "belongs_to" corresponds to the "foreign_key" specified in the User model. We have to state the "class_name" because "follower" is not a MODEL. Now, Rails knows to look for the User model.
  belongs_to :followed, class_name: "User"  # A "followed" is a User who does not click "follow". He is followed by other Users. It corresponds to the "followed_id" foreign key specified in the User model. We have to state the "class_name" because "follower" is not a MODEL. Now, Rails knows to look for the User model.

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

# Model can only use:
# column names
# associations
