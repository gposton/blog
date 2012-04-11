require 'paperclip'

class Post < ActiveRecord::Base
  acts_as_commentable

  before_validation :create_web_title

  validates_presence_of :title
  validates_presence_of :web_title
  validates_uniqueness_of :title
  validates_uniqueness_of :web_title

  has_and_belongs_to_many :tags

  def create_web_title
    return nil if self.title.nil?
    self.web_title = self.title.downcase.gsub(' ', '_').gsub(/\W/,'')
  end

  def to_param
    self.web_title
  end

  def to_s
    self.title
  end
end
