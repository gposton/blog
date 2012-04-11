class CreatePost < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string  :title
      t.string  :content
    end
  end

  def self.down
    drop_table :posts
  end
end
