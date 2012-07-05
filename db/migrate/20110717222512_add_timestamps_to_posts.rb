class AddTimestampsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :created_at, :timestamp
    add_column :posts, :updated_at, :timestamp
  end

  def self.down
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
