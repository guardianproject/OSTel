class AddDidToDomains < ActiveRecord::Migration
  def self.up
    add_column :domains, :did, :string, {:limit => 64}
    execute "UPDATE version set table_version=2 where table_name = 'domain'"
  end

  def self.down
    remove_column :domains, :did
    execute "UPDATE version set table_version=1 where table_name = 'domain'"
  end
end
