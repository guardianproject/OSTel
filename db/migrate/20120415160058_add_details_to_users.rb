class AddDetailsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :freeswitch_id, :integer
    add_column :users, :freeswitch_password, :string
  end

  def self.down
    remove_column :users, :freeswitch_password
    remove_column :users, :freeswitch_id
  end
end
