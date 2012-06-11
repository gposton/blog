class MigrateCommentToContent < ActiveRecord::Migration
  def up
    if column_exists? :comments, :comment
      add_column :comments, :content, :text
      Comment.all.each do |comment|
        comment.update_attributes :content => comment.comment
      end
      remove_column :comments, :comment
    end
  end

  def down
    add_column :comments, :comment, :text
    Comment.all.each do |comment|
      comment.update_attributes :comment => comment.content
    end
    remove_column :comments, :content
  end
end
