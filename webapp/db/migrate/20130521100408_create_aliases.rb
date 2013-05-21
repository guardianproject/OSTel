class CreateAliases < ActiveRecord::Migration
  def self.up
    create_table :aliases do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :aliases
  end
end
