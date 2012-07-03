Feature: Comments
  In order to let users comments
  The users
  Should be able to comment on a post

Scenario: The user can only comment on a post if he/she is signed in
    Given the following posts exist:
        | Title  | Content        |
        | Post 1 | Test content 1 |
    When a user visits the home page
    And follows 'Post 1'
    Then the user should see 'Sign in to post a comment.'
    And the 'Post' button should be disabled
    When a normal user logs in with google
    And follows 'Post 1'
    And enters Test Comment in the comment content field
    And clicks 'Post'
    Then the user should be on the post page with id, post_1
    And the user should see 'Test Comment'
