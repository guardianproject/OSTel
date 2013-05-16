class CreateKamailioDbaliases < ActiveRecord::Migration
  def self.up
    create_table :dbaliases do |t|
      t.string :alias_username, {:length => 64}
      t.string :alias_domain, {:length => 64}
      t.string :username, {:length => 64}
      t.string :domain, {:length => 64}
    end

    add_index :dbaliases, [:alias_username, :alias_domain], {:name => "alias_idx", :unique => true}
    add_index :dbaliases, [:username, :domain], {:name => "target_idx"}
  end

  def self.down
    drop_table :dbaliases
    remove_index :dbaliases, :name => "alias_idx"
    remove_index :dbaliases, :name => "target_idx"
  end
end
