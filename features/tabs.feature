Feature: Tabs
  In order to navigate
  The users
  Should have tabs and sub-tabs

Scenario: When on the blog a link to Poker and Picture Frame exists
    When a user visits the home page
    Then the user should see a link named "Poker"
    And the user should see a link named "Picture Frame"

Scenario: When on the blog sub tasks should exist to filter the blog by tags
    Given the following posts have been created
			| Title | Content | Tag |
			| Code  | Monkey  | Foo |
			| Is    | Awesome | Foo Bar |
    When a user visits the home page
    Then the user should see a link named "Foo"
    And the user should see a link named "Foo bar"
