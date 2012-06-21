class FixTimestamps < ActiveRecord::Migration
  def change
    change_column_default(:posts, :created_at, nil)
    change_column_default(:posts, :updated_at, nil)
  end
end
