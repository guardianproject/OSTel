class CreateKamailioVersionTable < ActiveRecord::Migration
  def self.up
    # this is a system table for kamailio and will never have a Rails model.
    # Rails requires a primary key to be created if using the create_table
    # method.
    execute "CREATE TABLE version (table_name varchar(64) NOT NULL, table_version integer DEFAULT 0 NOT NULL)"
  end

  def self.down
    drop_table :version
  end
end
