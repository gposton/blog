#DEPRECATED
class State < ActiveRecord::Base
  def closed?
    self.name == 'closed'
  end

  def scheduled?
    self.name == 'scheduled'
  end

  def open?
    self.name == 'open'
  end

  def self.open
    State.find_by_name 'open'
  end
end
