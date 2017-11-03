class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id  # id of the person who clicks "follow"
      t.integer :followed_id  # id of the person who receives 1 more follower.

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true # so can't have multiple instances of person A following B and vice-versa.
  end
end
