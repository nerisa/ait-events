@create_idea
Feature: Add new idea after signing in

  @omni_valid_login_setup
  @javascript
  Scenario: Adding a new idea

  A member who has logged in must be able to add new ideas

    Given there are committees
    Given I visit AIT Events
    Given I am signed in
    Then I should be able to see the form to add new ideas
    When I fill in the details
    When I click on the submit button
    Then I should be able to see the new idea

  @omni_valid_login_setup
  @javascript
    Scenario: Adding a comment to an idea

      Given there are committees
      Given I visit AIT Events
      Given I am signed in
      Then I should be able to see the form to add new ideas
      When I fill in the details
      When I click on the submit button
      Then I should be able to see the new idea
      Then I should be able to see a link to comment
      When I click on the link to comment
      Then I should add details about the comment
      Then I should be able to view the comment

