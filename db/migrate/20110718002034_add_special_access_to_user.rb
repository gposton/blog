class AddSpecialAccessToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :special_access, :boolean, :default => false
  end

  def self.down
    remove_column :users, :special_access
  end
end
