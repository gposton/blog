class AddTimestampsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :created_at, :timestamp, :default => 'CURRENT_TIMESTAMP'
    add_column :posts, :updated_at, :timestamp, :default => 'CURRENT_TIMESTAMP', :on_update => 'CURRENT_TIMESTAMP'
  end

  def self.down
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
