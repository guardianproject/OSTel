class AddUniqueIndexToSipUsername < ActiveRecord::Migration
  def self.up
    add_index :users, :sip_username, {:unique => true}
  end

  def self.down
    remove_index :users, :sip_username
  end
end
