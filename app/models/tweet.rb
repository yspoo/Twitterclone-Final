class Tweet < ApplicationRecord
  belongs_to :user
  # if you type user:references in terminal (rails g model Tweet user:references), then belongs_to :user will appear here automatically.
  # now every Tweet has an User ID associated with it.
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 } # tweets are capped at 140 chars.
  scope :latest, -> {order(created_at: :desc) } # latest tweets first.
  # scope :latest, -> { order("created_at DESC") } will also work.
  # now I can access the method "latest" on my Tweet model in the controller.
end
