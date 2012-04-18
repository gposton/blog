class Tag < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :posts

  def to_param
    self.name.gsub(' ', '_')
  end

  def self.find_by_param(param)
    Tag.find_by_name(param.gsub('_', ' '))
  end

end
