Given(/^I am a Super Admin$/) do
  @user = FactoryGirl.create :super_admin, is_super_admin: true, is_master_admin: false, is_member: false
end

Given(/^there are users$/) do
  @user1 = FactoryGirl.create :member, email: 'user1@ait.asia', id:100
  @user2 = FactoryGirl.create :member, email: 'user2@ait.asia'
end

Given(/^I am signed in$/) do
  visit '/'
  click_link('Sign in')
end

Then(/^I should see the admin menu$/) do
  expect(page).to have_link('Home')
  expect(page).to have_link('Dashboard')
  expect(page).to have_link('Banned Users')
end

Given(/^I am a regular user$/) do
  @user = FactoryGirl.create :super_admin, is_super_admin: false, is_master_admin: false, is_member: true
end

Then(/^I should not see the admin menu$/) do
  expect(page).to have_content('Home')
  expect(page).to have_no_content('Banned Users')
end

When(/^I click the link$/) do
  click_link('Dashboard')
end

Then(/^I should be able to see recently registered users$/) do
  expect(page).to have_content(@user1.email)
  expect(page).to have_content(@user2.email)
end

When(/^I click on the link ban$/) do
find(:xpath, "//a[@href='/users/ban_users?user_id=100']").click
end

Then(/^the user must be banned$/) do
  expect(page).to have_content("User #{@user1.email} has been banned from AIT Events ")
  # save_and_open_page
end

And (/^when i click on the banned users link$/) do
  click_link('Banned Users')
end

Given(/^There is a banned user$/) do
  @banned_user = FactoryGirl.create :member, email: 'banned@ait.asia', has_access: false
end

And(/^I see the admin menu$/) do
  expect(page).to have_link('Home')
  expect(page).to have_link('Dashboard')
  expect(page).to have_link('Banned Users')
end

When(/^I click the banned users menu$/) do
  click_link('Banned Users')
  # save_and_open_page
end

Then(/^I should see the banned user in the list$/) do
  expect(page).to have_content(@banned_user.email)
end

Then (/^I should be able to see a list of banned users$/) do
  expect(page).to have_content(@user1.email)
end