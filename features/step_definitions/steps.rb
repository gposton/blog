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
  case user_type
  when 'admin'
    User.last.update_attribute(:admin, true)
  when 'user with an email address'
    User.last.update_attribute(:email, 'me@me.com')
  when 'poker player'
    User.last.update_attribute(:poker_player, true)
  end
end

When /^enters (.*) in the (.*) field$/ do |text, field|
  fill_in(field.gsub(' ', '_'), :with => text)
end

When /^clicks '(.*)'$/ do |button|
 click_button button
end

When /^clicks the '(.*)' image$/ do |alt|
  find(:xpath, "//img[@alt = '#{alt}']").click()
end

When /^(?:the user )?follows '(.*)'/ do |link|
 click_link link
end

When /^uploads a photo$/ do
  attach_file('photo_image', File.join(Rails.root, 'public', 'images', 'on_the_rock.jpeg'))
  click_button 'Upload' 
end 

When /^selects "([^"]*)" from "([^"]*)"$/ do |option, field|
  select(option, :from => field)
end

When /^selects "([^"]*)"$/ do |option|
  select(option)
end

When /^checks '(.*)'$/ do |field|
  check(field)
end

Then /^the user should see '(.*)'$/ do |text|
  page.should have_content text
end

Then /^the user should not see '(.*)'$/ do |text|
  page.should_not have_content text
end

Then /^the user should see a link named '(.*)'$/ do |link|
  find_link(link).visible?.should be_true
end

Then /^the user should be on the (.*?) page(?: with id, (.*))?$/ do |page, id|
  current_path.should == self.send("#{page}_path", id)
end

Then /^the '(.*)' button should be disabled$/ do |id|
  page.should_not have_xpath "//input[@id='#{id}' and @disabled]"
end

Then /^the user should see the photo(?: in (.*))?$/ do |album_name|
  xpath = album_name ? "//div[@id='#{album_name}']/spam/img[@alt='On_the_rock']" : "//img[@alt='On_the_rock']"
  page.should have_xpath "//img[@alt='On_the_rock']"
end

Then /^the user should not see the photo$/ do
  xpath = "//img[@alt='On_the_rock']"
  page.should_not have_xpath xpath
end
