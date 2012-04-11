class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  validates :user_id, :uniqueness => {:scope => :tournament_id}

  def net
    self.winnings - self.buy_in
  end

  def loss?
    net < 0
  end
end
