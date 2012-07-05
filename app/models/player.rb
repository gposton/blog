class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  default_scope :order => 'created_at DESC'

  validates :user_id, :uniqueness => {:scope => :tournament_id}

  def net
    self.winnings - self.buy_in
  end

  def loss?
    net < 0
  end

  def name
    self.user.name
  end

  def toggle_no_show
    self.no_show = !no_show
    self
  end
end
