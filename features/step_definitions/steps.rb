Given /^the following posts have been created$/ do |table|
  table.hashes.map do |hash|
    post = Post.create(:title => hash['Title'], :content => hash['Content'])
    tag = Tag.create(:name => hash['Tag'], :posts => [post])
  end
end

When /^.*visits the (.*?) page$/ do |page|
  visit(self.send("#{page.gsub(' ','_')}_path"))
end

When /^a[n]? (.*) logs in with (.*)$/ do |user_type, oauth_provider|
  click_link('Sign out') rescue
  visit(home_path)
  OmniAuth.config.add_mock(oauth_provider, {:uid => '12345'})
  click_link("auth_#{oauth_provider}")
  User.last.update_attribute(:admin, user_type.include?('admin'))
end

When /^enters (.*) in the (.*) field$/ do |text, field|
  fill_in(field.gsub(' ', '_'), :with => text)
end

When /^clicks '(.*)'/ do |button|
 click_button button
end

When /^follows '(.*)'/ do |link|
 #href = find_link(link)[:href] 
 #visit(href)
 click_link link
end

Then /^the user should see '(.*)'$/ do |text|
  page.should have_content text
end

Then /^the user should see a link named '(.*)'$/ do |link|
  find_link(link).visible?.should be_true
end

Then /^the user should be on the (.*?) page(?: with id, (.*))?$/ do |page, id|
  current_path.should == self.send("#{page}_path", id)
end
