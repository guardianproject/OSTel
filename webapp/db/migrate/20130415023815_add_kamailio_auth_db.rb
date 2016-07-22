class AddKamailioAuthDb < ActiveRecord::Migration
  def self.up
    add_column :users, :ha1, :string
    add_column :users, :ha1b, :string
    add_column :users, :domain, :string
    add_column :users, :sip_username, :string
  end

  def self.down
    remove_column :users, :ha1
    remove_column :users, :ha1b
    remove_column :users, :domain
    remove_column :users, :sip_username
  end
end
