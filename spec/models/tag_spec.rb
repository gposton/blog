require File.dirname(__FILE__) + "/../spec_helper"

describe Tag do
  it 'validates the presence and uniqueness of name' do
    Tag.new(:name => nil).should_not be_valid
    Factory.create(:tag, :name => 'tag')
    Factory.build(:tag, :name => 'tag').should_not be_valid
  end
end
