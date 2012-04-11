require File.dirname(__FILE__) + "/../spec_helper"

describe Tournament do
  before :each do
    @tournament = Factory.create(:tournament)
  end

  it 'accepts and validates nested attributes for players' do
    tournament = Factory.create(:tournament, :players => [Factory.build(:player), Factory.build(:player)])
    tournament.players.size.should be 2
  end

  it 'validates that a date is present' do
    Factory.build(:tournament, :date => nil).should_not be_valid
  end

  it 'validates that a state is present' do
    Factory.build(:tournament, :state => nil).should_not be_valid
  end

  it 'validates that a name is automatically created and that it is unique' do
    tournament = Factory.create(:tournament, :name => nil)
    tournament.name.should_not be_nil
    Factory.build(:tournament, :name => tournament.name).should_not be_valid
  end

  it 'determines if a user is already in the tournament' do
    player = Factory.create(:player)
    @tournament.has_player?(player.user).should be_false
    @tournament.players << player
    @tournament.has_player?(player.user).should be_true
  end

  it 'returns the date as a string' do
    tournament = Factory.create(:tournament, :date => Date.new(2001, 1, 1))
    tournament.date_string.should == '1/1/2001'
  end

  it 'returns the total pot' do
    @tournament.total_pot.should be 0
    @tournament.players << Factory.create(:player, :buy_in => 20)
    @tournament.total_pot.should be 20
    @tournament.players << Factory.create(:player, :buy_in => 20)
    @tournament.total_pot.should be 40
  end

  it 'returns the winners of the tournament' do
    @tournament.winners.count.should be 0
    @tournament.players << Factory.create(:player, :finish => 2)
    @tournament.winners.count.should be 0
    @tournament.players << Factory.create(:player, :finish => 1)
    @tournament.winners.count.should be 1
    @tournament.players << Factory.create(:player, :finish => 1)
    @tournament.winners.count.should be 2
  end

  it 'returns a list of all tournaments from the last week' do
    Tournament.last_weeks_games.count.should be 0
    Factory.create(:tournament, :date => Date.today - 7)
    Tournament.last_weeks_games.count.should be 0
    Factory.create(:tournament, :date => (Date.today - 6))
    Tournament.last_weeks_games.count.should be 1
    Factory.create(:tournament, :date => (Date.today - 1))
    Tournament.last_weeks_games.count.should be 2
    Factory.create(:tournament, :date => Date.today)
    Tournament.last_weeks_games.count.should be 3
  end

  it 'uses the tournament name as the id in the url' do
    @tournament.to_param.should be @tournament.name
  end
end
