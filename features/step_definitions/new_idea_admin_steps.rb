Given(/^I see admin menu$/) do
  expect(page).to have_link('Home')
  expect(page).to have_link('Dashboard')
  expect(page).to have_link('Banned Users')
  expect(page).to have_link('New Ideas')
end

Given(/^There are new ideas$/) do
  @user = FactoryGirl.create :member, email: "email@email.com"
  @committee = FactoryGirl.create :committee
  @new_idea = FactoryGirl.create :new_idea, is_closed: false, restrict_display: false, user: @user, committee: @committee
end


When(/^I click on the new idea menu$/) do
  click_link('New Ideas')
  save_and_open_page
end

Then(/^I should see the new ideas$/) do
  expect(page).to have_content(@new_idea.name)
  save_and_open_page
end

Given(/^There is a idea which is not closed and not banned$/) do
  @user = FactoryGirl.create :member, email: "email@email.com"
  @committee = FactoryGirl.create :committee
  @new_idea = FactoryGirl.create :new_idea, name: 'My event 23',is_closed: false, restrict_display: false, user: @user, committee: @committee
end

Then(/^I should see buttons to close and ban the idea$/) do
  expect(page).to have_link('Close')
  expect(page).to have_link('Restrict Display')
end

When(/^I click on close idea button$/) do
  click_link('Close')
end

Then(/^The idea should be closed$/) do
  expect(page).to have_content('This idea has been closed')
end

When(/^I click on ban idea button$/) do
  click_link('Restrict Display')
end

Then(/^The idea should be banned$/) do
  expect(page).to have_content('This idea has been banned')
end







