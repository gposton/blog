class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :user_id, :content

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
end
