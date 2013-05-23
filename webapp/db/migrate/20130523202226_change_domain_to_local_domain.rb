class ChangeDomainToLocalDomain < ActiveRecord::Migration
  def self.up
    rename_column :aliases, :domain, :local_domain
    rename_column :aliases, :username, :local_username
  end

  def self.down
    rename_column :aliases, :local_domain, :domain
    rename_column :aliases, :local_username, :username
  end
end
