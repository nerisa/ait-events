@create_idea
Feature: Super Admin Dashboard

  @omni_valid_login_setup
  Scenario: Super Admin should be able to see the admin menu when he logs in
    Given I am a Super Admin
    And I am signed in
    Then I should see the admin menu

  @omni_valid_login_setup
  Scenario: Logged in user who donot have super admin previlage should not see the admin menu
    Given I am a regular user
    And I am signed in
    Then I should not see the admin menu

  @omni_valid_login_setup
  Scenario: A logged in Super Admin should be able to see the dashboard

    Given I am a Super Admin
    Given there are users
    And I am signed in
    Then I should see the admin menu
    When I click the link
    Then I should be able to see recently registered users

  @omni_valid_login_setup
  Scenario: A logged in Super Admin should be able to ban users

    Given I am a Super Admin
    Given there are users
    And I am signed in
    Then I should see the admin menu
    When I click the link
    Then I should be able to see recently registered users
    When I click on the link ban
    Then the user must be banned
    And when i click on the banned users link
    Then I should be able to see a list of banned users

  @omni_valid_login_setup
  Scenario: Super Admin should be able to access the banned users page
    Given There is a banned user
    Given I am a Super Admin
    And I am signed in
    And I see the admin menu
    When I click the banned users menu
    Then I should see the banned user in the list