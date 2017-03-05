@create_idea
Feature: Sign in with AIT email account

  @omni_valid_login_setup

  Scenario: Sign in with AIT email

  A user who has an AIT email should be able to sign in.

    Given I visit AIT Events
    Then I should see a sign in link
    When I click the sign in link
    Then I should be successfully logged in

  @omni_invalid_login_setup

  Scenario: Sign in with other gmail accounts

  A user without an AIT email should not be able to sign in.

    Given I visit AIT Events
    Then I should see a sign in link
    When I click the sign in link
    Then I should be not be able to sign in

  @omni_valid_login_setup

  Scenario: Banned user cannot sign in

  A banned user cannot sign in

    Given I visit AIT Events
    And I am a banned user
    When I click the sign in link
    Then As i'm banned I should not be able to sign in