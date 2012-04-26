Feature: Photos
  In order to supply pictures to my digital picture frame
  The users
  Should be able to view and upload pictures to albums


Scenario: Only admins can create new albums
    When a user visits the home page
    And follows 'Picture Frame'
    Then the user should not see 'Create album'
    When an admin logs in with google
    And follows 'Picture Frame'
    And enters Album 1 in the Name field
    And clicks 'Create album'
    Then the user should be on the albums page
    And the user should see 'Album 1'

Scenario: The user can only upload photos if he/she is signed in
    When a user visits the home page
    And follows 'Picture Frame'
    And uploads a photo
    Then the user should not see the photo
    And the user should see 'You'll need to sign in first.'
    When a normal user logs in with google
    And follows 'Picture Frame'
    And uploads a photo
    Then the user should be on the albums page
    And the user should see the photo

Scenario: Only admins can upload a photo to an album other than 'New'
    Given the following albums exist:
       | Name     |
       | Pictures |
    When a normal user logs in with google
    And follows 'Picture Frame'
    Then the user should not see 'Album'
    When an admin logs in with google
    And follows 'Picture Frame'
    And selects "Pictures" from "photo_album_id"
    And uploads a photo
    Then the user should see the photo in Pictures
