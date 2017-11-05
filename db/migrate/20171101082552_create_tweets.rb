class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :content,  null: false
      t.references :user, index: true,  foreign_key: true # reference to a MODEL(singular), not TABLE(plural)
      t.timestamps
    end
    add_index :tweets, [:user_id, :created_at] # compound index
  end
end
=begin
In this case, t.references creates a user_id column in the tweets table. That means that Tweet belongs to User, so in Tweet model I have to add belongs_to :user and in User model: has_many :tweets .
=end
