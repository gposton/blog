class ChangePostContentToLongText < ActiveRecord::Migration
  def self.up
    change_column :posts, :content, :longtext
  end

  def self.down
  end
end
