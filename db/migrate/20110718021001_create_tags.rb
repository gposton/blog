class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :posts_tags, :id => false do |t|
      t.column 'post_id', :integer, :null => false
      t.column 'tag_id',  :integer, :null => false
    end
  end

  def self.down
    drop_table :tags
    drop_table :posts_tags
  end
end
