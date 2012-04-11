class AddWebTitleToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :web_title, :string
    Post.all.each do |post|
      post.web_title = post.title.downcase.gsub(' ', '_')
      post.save
    end
  end

  def self.down
    remove_column :posts, :web_title
  end
end
