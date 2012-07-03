require File.dirname(__FILE__) + "/../spec_helper"

describe Tournament do
  before :each do
    @date = '2001_01_01'
    @tournament = FactoryGirl.create(:tournament)
  end

  it 'sets the game number for new tournaments' do
    @tournament.game_number.should be 1
    Tournament.create(@tournament.attributes).game_number.should == 2
    Tournament.create(@tournament.attributes).game_number.should == 3
  end

  it 'accepts and validates nested attributes for players' do
    tournament = FactoryGirl.create(:tournament, :players => [FactoryGirl.build(:player), FactoryGirl.build(:player)])
    tournament.players.size.should be 2
  end

  it 'validates that a date is present' do
    FactoryGirl.build(:tournament, :date => nil).should_not be_valid
  end

  it 'determines if a user is already in the tournament' do
    player = FactoryGirl.create(:player)
    @tournament.has_player?(player.user).should be_false
    @tournament.players << player
    @tournament.has_player?(player.user).should be_true
  end

  it 'returns the date as a string' do
    tournament = FactoryGirl.create(:tournament, :date => Date.new(2001, 1, 1))
    tournament.date_string.should == '1/1/2001'
  end

  it 'returns the total pot' do
    @tournament.total_pot.should be 0
    @tournament.players << FactoryGirl.create(:player, :buy_in => 20)
    @tournament.total_pot.should be 20
    @tournament.players << FactoryGirl.create(:player, :buy_in => 20)
    @tournament.total_pot.should be 40
  end

  it 'returns the winners of the tournament' do
    @tournament.winners.count.should be 0
    @tournament.players << FactoryGirl.create(:player, :finish => 2)
    @tournament.winners.count.should be 0
    @tournament.players << FactoryGirl.create(:player, :finish => 1)
    @tournament.winners.count.should be 1
    @tournament.players << FactoryGirl.create(:player, :finish => 1)
    @tournament.winners.count.should be 2
  end

  it 'returns a list of the last 3 completed tournaments' do
    Tournament.last_weeks_games.count.should be 1
    FactoryGirl.create(:tournament, :date => (Date.today + 1)) #This one is in the future so it should not be counted
    Tournament.last_weeks_games.count.should be 1
    FactoryGirl.create(:tournament, :date => Date.today - 7)
    Tournament.last_weeks_games.count.should be 2
    FactoryGirl.create(:tournament, :date => (Date.today - 6))
    Tournament.last_weeks_games.count.should be 3
    FactoryGirl.create(:tournament, :date => (Date.today - 5)) #This one should not be counted because only 3 should be returned
    Tournament.last_weeks_games.count.should be 3
  end

  it 'uses the tournament date as the id in the url' do
    @tournament = FactoryGirl.create(:tournament, :date => Date.new(2011,1,2))
    @tournament.to_param.should be == '1-2-2011_1'
  end
end
