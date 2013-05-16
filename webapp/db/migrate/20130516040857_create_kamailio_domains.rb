class CreateKamailioDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :domain, {:limit => 64, :default => '', :null => false}
      t.timestamp :last_modified, {:default => '1900-01-01 00:00:01', :null => false}
    end
    execute "INSERT INTO version (table_name, table_version) values ('domains','1')"

    add_index :domains, "domain", :unique => true
  end

  def self.down
    drop_table :domains
  end
end
