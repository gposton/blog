Feature: Posts
  In order to have a blog
  The users
  Should be able to read things that I post

Scenario: The homepage is a list or posts
    Given the following posts exist:
      | Title  | Content        |
      | Post 1 | Test content 1 |
      | Post 2 | Test content 2 |
    When a user visits the home page
    Then the user should see 'Test content 1'
    And the user should see 'Test content 2'
    And the user should see a link named 'Post 1'
    And the user should see a link named 'Post 2'

Scenario: Only admin users can create a post
    When a normal user logs in with google
    And visits the new_post page
    Then the user should see 'You need to be an admin to do that!'
    When an admin logs in with google
    And visits the new post page
    And enters Post in the post title field
    And enters Test Content in the post content field
    And clicks 'Create Post'
    Then the user should be on the post page with id, post
    And the user should see 'Test Content'
