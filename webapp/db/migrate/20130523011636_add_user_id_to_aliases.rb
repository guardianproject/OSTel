class AddUserIdToAliases < ActiveRecord::Migration
  def self.up
    add_column :dbaliases, :user_id, :integer
  end

  def self.down
    remove_column :dbaliases, :user_id
  end
end
