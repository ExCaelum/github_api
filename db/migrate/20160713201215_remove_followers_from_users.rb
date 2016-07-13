class RemoveFollowersFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :followers
  end
end
