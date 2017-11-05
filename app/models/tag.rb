class Tag < ApplicationRecord
  has_many :tweet_tags, dependent: :destroy
  has_many :tweets, through: :tweet_tags

  validates :content, presence: true, uniqueness: :true
=begin
Note: 1) the _ underscore.
      2) has_many => so plural
      3) dependent: :destroy - so that when we destroy a tag, all
=end
end
