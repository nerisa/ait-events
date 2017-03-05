Given(/^I am a master admin$/) do
  @user = FactoryGirl.create :super_admin, is_super_admin: false, is_master_admin: true, is_member: false
  @committee = FactoryGirl.create :committee, user: @user
end

Given(/^I have an event/) do
  @event = FactoryGirl.build :event
end

When(/^I visit my committee page$/) do
  visit committee_url(@committee)
  save_and_open_page
end

Then(/^I should see a link to create events$/) do
  expect(page).to have_link 'Create an Event'
end

When(/^I click on the create event link$/) do
  click_link 'Create an Event'
end

Then(/^I should see a form to create event$/) do
  expect(page).to have_selector('form#new_event')
end

When(/^I submit the event form$/) do
  fill_in 'Name of the event', with: @event.name
  fill_in 'Describe the event', with: @event.description
  click_button 'Create'
end

Then(/^I should see the event details$/) do
  expect(page).to have_content @event.name
  expect(page).to have_content @event.description
end

Given(/^I have a previously created event/) do
  @event = FactoryGirl.create :event, committee: @committee
end

Given(/^I want to post an announcement/) do
  @announcement = FactoryGirl.build :announcement
end

Then(/^I should see my event in the page$/) do
  expect(page).to have_content @event.name
end

When(/^I visit the event page$/) do
  visit event_url(@event)
end

Then(/^I should see a form to add announcements$/) do
  expect(page).to have_selector('form#new_announcement')
  save_and_open_page
end

When(/^I post an announcement$/) do
  fill_in 'announcement_description', with: @announcement.description
  click_button 'Post'
end

Then(/^I should see the announcement posted on the event page$/) do
  expect(page).to have_content @announcement.description
end
