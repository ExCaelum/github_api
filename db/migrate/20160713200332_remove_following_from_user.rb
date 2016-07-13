class RemoveFollowingFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :following
  end
end
