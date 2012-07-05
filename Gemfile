source 'http://rubygems.org'

gem 'rails', '3.2.3'

gem 'pg'

gem 'thin'

gem 'jquery-rails'
gem 'best_in_place', :git => 'https://github.com/gposton/best_in_place.git'

gem 'omniauth-openid'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'friendly_id'
gem 'paperclip'
gem 'acts_as_commentable'
gem 'whenever'
gem 'encryptor'

gem 'haml'
gem 'RedCloth'
gem 'tabs_on_rails'
gem 'googlecharts'

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'uglifier', '>= 1.0.3'
end


group :development do
  gem 'guard-ctags-bundler'
  gem 'capistrano'
  gem 'sqlite3'
  gem 'taps'
  gem 'heroku'
end

group :test do
  # Pretty printed test output
  # gem 'turn', '0.8.2', :require => false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # Was getting a warning when running spork, require false to fix
  # http://datacodescotch.blogspot.com/2011/11/warning-cucumber-rails-required-outside.html
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'spork'
  gem 'autotest-growl'
  gem 'show_me_the_cookies'
  gem 'database_cleaner'
  gem 'autotest-rails'
end
