class Tournament < ActiveRecord::Base
  extend FriendlyId
  friendly_id :url_string, :use => :slugged

  has_many :players, :dependent => :delete_all

  accepts_nested_attributes_for :players, :allow_destroy => true

  validates_associated :players
  validates_presence_of :date

  before_create :set_game_number

  default_scope :order => 'date DESC'

  def has_player?(user)
    self.players.any?{|player| player.user_id == user.id}
  end

  def date_string
    self.date.strftime("%-m/%-d/%Y") rescue ''
  end

  def name
    game_str = Tournament.all_on(self.date).count > 1 ? " Game #{self.game_number}" : ''
    "#{self.date_string}#{game_str}"
  end

  def total_pot
    return 0 if self.players.empty?
    self.players.collect{|player|player.buy_in}.inject(:+)
  end

  def today?
    self.date == Date.today
  end

  def over?
    self.date < Date.today
  end

  def winners
    self.players.keep_if{|player|player.finish == 1}
  end

  def url_string
    self.persisted? ? self.slug : "#{self.date_string}_#{self.game_number}".parameterize
  end

  def game_number
    self.persisted? ? self[:game_number] : set_game_number
  end

  def set_game_number
    tournament_count = Tournament.all_on(self.date).count
    self.game_number = tournament_count + 1
  end

  def pending_rsvps
    rsvpd_user_ids = self.players.map{|player| player.user.id}
    User.poker_players.delete_if{|user| rsvpd_user_ids.include? user.id}
  end

  def self.all_on(date)
    Tournament.find(:all, :conditions => ["date = ?", date])
  end

  def self.last_weeks_games
    Tournament.find(:all, :limit => 3, :conditions => ["date < ?", Date.today])
  end
end
