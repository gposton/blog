class Tournament < ActiveRecord::Base
  has_many :players
  belongs_to :state

  accepts_nested_attributes_for :players, :allow_destroy => true

  validates_associated :players
  validates_presence_of :date
  validates_presence_of :state
  validates_uniqueness_of :name

  before_create :set_tournament_name

  default_scope :order => 'date DESC'

  def has_player?(user)
    self.players.any?{|player| player.user_id == user.id}
  end

  def date_string
    self.date.strftime("%-m/%-d/%Y")
  end

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

  def set_tournament_name
    self.name = self.date.strftime("%Y_%m_%d")
  end

  def to_param
    self.name
  end
end
