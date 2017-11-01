class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|

      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :tweets, [:user_id, :created_at] # compound index
  end
end
