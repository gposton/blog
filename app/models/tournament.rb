class Tournament < ActiveRecord::Base
  has_many :players
  belongs_to :state

  accepts_nested_attributes_for :players, :allow_destroy => true

  validates_associated :players
  validates_presence_of :date
  validates_presence_of :state

  default_scope :order => 'date DESC'

  def has_player?(user)
    self.players.any?{|player| player.user_id == user.id}
  end

  def date_string
    self.date.strftime("%-m/%-d/%Y")
  end
  alias :name :date_string

  def total_pot
    return 0 if self.players.empty?
    self.players.collect{|player|player.buy_in}.inject(:+)
  end

  def winners
    self.players.keep_if{|player|player.finish == 1}
  end

  def self.last_weeks_games
    Tournament.all.keep_if{|tournament|tournament.date > (Date.today - 7)}
  end

  def to_param
    self.date.strftime("%Y_%m_%d")
  end
end
