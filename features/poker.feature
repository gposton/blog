Feature: Poker
  In order to track and set up poker games
  The users
  Should be able to subscribe to see each game's results

@javascript
Scenario: Create a new tournament
    When an admin logs in with google
    And visits the new_tournament page
    And clicks the 'Calendar' image
    And selects "January"
    And selects "2011"
    And picks the 1st from the calendar
    And clicks 'Create Tournament'
    Then the user should see '1/1/2011'

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

Scenario: A user can see a list of all tournaments
    Given the following tournaments exist:
        | Date       |
        | 01-01-2011 |
        | 02-01-2011 |
    When a poker player logs in with google
    And follows 'Poker'
    Then the user should see '1/1/2011'
    And the user should see '1/1/2011'

#Scenario: A user can see tournament results
    #Given the following users exist:
        #| Name  | id |
        #| Glenn | 1  |
        #| Paul  | 2  |
    #And the following tournaments exist:
        #| Date       | id |
        #| 01-01-2011 | 1  |
    #And the following players exist:
        #| User id | Tournament id | Buy in | Winnings | Finish |
        #| 1       | 1             | 10     | 30       | 1      |
        #| 2       | 1             | 20     | 0        | 2      |
    #When a poker player logs in with google
    #And follows 'Poker'
    #And follows '1/1/2011'
    #And the user should see 'Buy in'
    #And the user should see 'Winnings'
    #And the user should see 'Finish'
    #Then the user should see 'Glenn'
    #And the user should see '10'
    #And the user should see '30'
    #And the user should see '1'
    #And the user should see 'Paul'
    #And the user should see '20'
    #And the user should see '10'
    #And the user should see '2'

@javascript
Scenario: Only admins can create new tournaments
    When a normal user logs in with google
    And visits the new_tournament page
    Then the user should see 'You need to be an admin to do that!'

Scenario: A user can RSVP to a tournament
    Given the following tournaments exist:
        | Date       | id |
        | 01-01-2050 | 1  |
    When a poker player logs in with google
    And follows 'Poker'
    And follows '1/1/2050'
    And follows 'I'll be there'
    Then the user should see 'Poker Player'
    And the user should see 'Can't make it'
    And the user should not see 'I'll be there'

Scenario: Only admins can add other users to a tournament
#Scenario: A user can enter their tournament results
    #Given the following users exist:
        #| Name  | id |
        #| Glenn | 1  |
        #| Paul  | 2  |
    #And the following tournaments exist:
        #| Date       | id |
        #| 01-01-2011 | 1  |
    #And the following players exist:
        #| User id | Tournament id | Buy in | Winnings | Finish |
        #| 1       | 1             | 10     | 30       | 1      |
        #| 2       | 1             | 20     | 0        | 2      |
    #When a poker player logs in with google
    #And follows 'Poker'
    #And follows '1/1/2011'
    #Then the user should see 'edit' in the row for user 1
    #Then the user should not see 'update' in the row for user 2
    #When the user follows 'edit'
    #Then the user should see 10
    #And the user should see 30
    #When the user enters 20 in the 'Buy in' field
    #And clicks 'Update'
    #Then the user should see 20 in the row for user 1
    #And the user should see 10 in the row for user 1
