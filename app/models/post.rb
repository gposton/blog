require 'paperclip'

class Post < ActiveRecord::Base
  acts_as_commentable

  before_create :create_web_title

  validates_presence_of :title
  validates_uniqueness_of :title

  has_and_belongs_to_many :tags

  def create_web_title
    # replace 'spaces' with 'underscores' and get rid of any odd characters
    self.web_title = self.title.downcase.gsub(' ', '_').gsub(/\W/,'')
    # make sure that the web_title is unique
    # get everything that has a similar web_title
    previous_posts_with_same_web_title = Post.find_by_sql "Select * from posts where web_title like '#{web_title}%'"
    # append the new web title with max_id + 1 (note the 'order by' in the sql above)
    self.web_title = "#{self.web_title}_#{previous_posts_with_same_web_title.size}" unless previous_posts_with_same_web_title.empty?
  end

  def to_param
    self.web_title
  end
end
