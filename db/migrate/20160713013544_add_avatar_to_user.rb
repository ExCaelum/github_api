class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :followers, :string
    add_column :users, :following, :string
  end
end
