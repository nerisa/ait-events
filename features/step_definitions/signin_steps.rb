Given(/^I visit AIT Events$/) do
  visit '/'
end

Then(/^I should see a sign in link$/) do
  expect(page).to have_link('Sign in')
end

When(/^I click the sign in link$/) do
  click_link('Sign in')
end

Then(/^I should be successfully logged in$/) do
  expect(page).to have_content('Signed in as John Doe')
end

Then(/^I should be not be able to sign in$/) do
  expect(page).to have_content('Please login using your AIT email')
end

And(/^I am a banned user$/) do
  @user = FactoryGirl.create :super_admin, has_access: false
end

Then(/^As i'm banned I should not be able to sign in$/) do
  expect(page).to have_content('You  have been revoked access to this page')
end





