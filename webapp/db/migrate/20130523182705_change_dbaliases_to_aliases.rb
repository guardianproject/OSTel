class ChangeDbaliasesToAliases < ActiveRecord::Migration
  def self.up
    rename_table :dbaliases, :aliases
  end

  def self.down
    rename_table :aliases, :dbaliases 
  end
end
