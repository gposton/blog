Feature: Social
  In order for people to stay up to date
  The user
  Should have rss feeds and a link to my twitter profile

Scenario: Follow me on twitter
    When a user visits the home page
    Then the user should see a link named 'twitter'

Scenario: RSS feed
    When a user visits the home page
    Then the user should see a link named 'rss_feed'
