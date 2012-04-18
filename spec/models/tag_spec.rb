require File.dirname(__FILE__) + "/../spec_helper"

describe Tag do
  it 'validates the presence and uniqueness of name' do
    Tag.new(:name => nil).should_not be_valid
    FactoryGirl.create(:tag, :name => 'tag')
    FactoryGirl.build(:tag, :name => 'tag').should_not be_valid
  end

  it 'returns a parameter for use in URLs (replaces " " with "_")' do
    tag = FactoryGirl.create(:tag, :name => 'some tag')
    tag.to_param.should be == 'some_tag'
  end

  it 'can lookup by url param' do
    FactoryGirl.create(:tag, :name => 'some tag')
    tag = Tag.find_by_param 'some_tag'
    tag.name.should be == 'some tag'
  end
end
