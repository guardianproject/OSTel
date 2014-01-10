class TokenAuthentication < ActiveRecord::Migration
  def self.up
    add_column :users, :authentication_token, :string
    User.find_each do |u|
      u.ensure_authentication_token!
    end
  end

  def self.down
    remove_column :users, :authentication_token, :string
  end
end
