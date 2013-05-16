class CreateKamailioDbaliases < ActiveRecord::Migration
  def self.up
    create_table :dbaliases do |t|
      t.string :alias_username, {:limit => 64, :null => false, :default => ""}
      t.string :alias_domain, {:limit => 64, :null => false, :default => ""}
      t.string :username, {:limit => 64, :null => false, :default => ""}
      t.string :domain, {:limit => 64, :null => false, :default => ""}
    end

    add_index :dbaliases, [:alias_username, :alias_domain], {:name => "alias_idx", :unique => true}
    add_index :dbaliases, [:username, :domain], {:name => "target_idx"}
    execute("INSERT INTO version (table_name, table_version) values ('dbaliases','1')")
  end

  def self.down
    drop_table :dbaliases
    remove_index :dbaliases, :name => "alias_idx"
    remove_index :dbaliases, :name => "target_idx"
  end
end
