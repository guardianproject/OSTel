class AddDomainIdToAliases < ActiveRecord::Migration
  def self.up
    add_column :aliases, :domain_id, :integer
  end

  def self.down
    remove_column :aliases, :domain_id
  end
end
