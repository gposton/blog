Feature: Poker
  In order to track and set up poker games
  The users
  Should be able to subscribe to see each game's results

Scenario: A user must be signed in to see tournament information and to register for poker updates
    Given the following tournaments exist:
        | Date       |
        | 01-01-2011 |
    When a user visits the home page
    And follows 'Poker'
    Then the user should see 'You'll need to sign in first.'
    When a user with an email address logs in with google
    And follows 'Poker'
    Then the user should see 'Register'
    And the user should not see '1/1/2011'
    When the user follows 'Register'
    Then the user should see 'You'll now receive poker updates at me@me.com'
    And the user should see '1/1/2011'

Scenario: A user is prompted for their email when the register if they haven't already entered one
    When a normal user logs in with google
    And follows 'Poker'
    And follows 'Register'
    And enters me@me.com in the user_email field
    And checks 'user_poker_player'
    And clicks 'Register'
    Then the user should see 'You'll now receive poker updates at me@me.com'

Scenario: A user can unsubscribe from poker
    When a user with an email address logs in with google
    And follows 'Poker'
    And follows 'Register'
    Then the user should see 'You'll now receive poker updates at me@me.com'
    When the user follows 'Unsubscribe'
    Then the user should see 'You'll no longer receive poker updates at me@me.com'
