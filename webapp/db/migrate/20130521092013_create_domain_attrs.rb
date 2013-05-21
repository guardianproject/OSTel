class CreateDomainAttrs < ActiveRecord::Migration
  def self.up
    create_table :domain_attrs do |t|
      t.string :did, {:limit => 64, :null => false}
      t.string :name, {:limit => 32, :null => false}
      t.integer :type, {:null => false}
      t.string :value, {:null => false}
      t.timestamp :last_modified, {:default => '1900-01-01 00:00:01', :null => false}
    end
    execute "INSERT INTO version (table_name, table_version) values ('domain_attrs','1')"

    add_index :domain_attrs_domain_attrs_idx, ["did","name","value"], :unique => true
  end

  def self.down
  end
end
