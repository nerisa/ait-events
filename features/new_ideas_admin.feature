#@create_idea
Feature: New Ideas - Admin

  @omni_valid_login_setup

  Scenario: A logged in admin should be able to see the new ideas

    Given There are new ideas
    And I am a Super Admin
    And I am signed in
    And I see admin menu
    When I click on the new idea menu
    Then I should see the new ideas


  @omni_valid_login_setup
  @javascript

  Scenario: Superadmin should be able to ban and close a new idea

    Given There is a idea which is not closed and not banned
    And I am a Super Admin
    And I am signed in
    And I see admin menu
    When I click on the new idea menu
    Then I should see the new ideas
    And I should see buttons to close and ban the idea
    When I click on close idea button
    Then The idea should be closed
    When I click on ban idea button
    Then The idea should be banned