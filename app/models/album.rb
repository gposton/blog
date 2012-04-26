class Album < ActiveRecord::Base
  has_many :photos

  validates_presence_of :name

  def to_param
    self.name
  end
end
