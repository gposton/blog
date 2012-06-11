class MigrateCommentToContent < ActiveRecord::Migration
  def up
    add_column :comment, :content, :text
    Comment.all.each do |comment|
      comment.update_attributes :content => comment.comment
    end
    remove_column :comment :comment
  end

  def down
    add_column :comment, :comment, :text
    Comment.all.each do |comment|
      comment.update_attributes :comment => comment.content
    end
    remove_column :comment :content
  end
end
