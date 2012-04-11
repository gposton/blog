require File.dirname(__FILE__) + "/../spec_helper"

describe State do
  before :each do
    @scheduled = State.find_by_name 'scheduled'
    @open = State.find_by_name 'open'
    @closed = State.find_by_name 'closed'
  end

  it 'answer if the state is "closed"' do
    @closed.closed?.should be_true
    @open.closed?.should be_false
  end

  it 'answer if the state is "scheduled"' do
    @scheduled.scheduled?.should be_true
    @open.scheduled?.should be_false
  end

  it 'answer if the state is "open"' do
    @open.open?.should be_true
    @closed.open?.should be_false
  end

  it 'returns the open state' do
    State.open.should == @open
  end
end
