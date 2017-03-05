@create_idea
Feature: Admin Event Features

  Admin should be able to create and edit the events

  @omni_valid_login_setup
  Scenario: Create a new event

    Given I am a master admin
    And I am signed in
    And I have an event
    When I visit my committee page
    Then I should see a link to create events
    When I click on the create event link
    Then I should see a form to create event
    When I submit the event form
    Then I should see the event details

#    TODO not working when @javascript is used
  @omni_valid_login_setup
  @javascript
  Scenario: Add announcements to event

    Given I am a master admin
    And I am signed in
    And I have a previously created event
    And I want to post an announcement
    When I visit my committee page
    Then I should see my event in the page
    When I visit the event page
    Then I should see the event details
    And I should see a form to add announcements
    When I post an announcement
    Then I should see the announcement posted on the event page