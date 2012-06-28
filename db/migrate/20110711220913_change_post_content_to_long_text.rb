class ChangePostContentToLongText < ActiveRecord::Migration
  def self.up
    change_column :posts, :content, :text
  end

  def self.down
  end
end
