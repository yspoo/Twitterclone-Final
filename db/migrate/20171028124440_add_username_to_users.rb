class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column  :users,  :username,  :string # add a new column to table "user", called "username" and of type "string". These values will all be in symbols. A symbol is an identifier for something that has an important meaning.
    add_index :users,  :username,  unique: true  # we want to index the username column in the user database(and make sure that it is unique). Indexing a database column takes a little bit more space but gives us very rapid lookup times.
    # first, index usernames for quick lookup. Second, ensure usernames are always unique.
  end
end

# Now, type rake db:migrate in Terminal to load this migration into the database schema.
