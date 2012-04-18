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
  And follows 'Add comment'
  Then the user should see 'You'll need to sign in first.'
  When a normal user logs in with google
  And follows 'Post 1'
  And follows 'Add comment'
  And enters Test Comment in the comment content field
  And clicks 'Create Comment'
  Then the user should be on the post page with id, post_1
  And the user should see 'Test Comment'
