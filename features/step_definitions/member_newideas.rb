Then (/^I should be able to see the form to add new ideas$/) do
  expect(page).to have_content('Do you have any new ideas?')
  save_and_open_page
end
Given (/^there are committees$/) do
  FactoryGirl.create :committee
end

When (/^I fill in the details$/) do
  fill_in 'What would you name this event?', with: "event1"
  fill_in 'Please describe this event for us', with: "Funny event"
  select('Gender', :from => 'Which SU committee would this event fall under?')
end

When (/^I click on the submit button$/) do
  click_button 'Submit'
end

Then (/^I should be able to see the new idea$/) do
  expect(page).to have_content ('event1')
  expect(page).to have_content ('Funny event')
end

Then (/^I should be able to see a link to comment$/) do
  expect(page).to have_link('event1')
end

When (/^I click on the link to comment$/) do
  click_link('event1')
  save_and_open_page
end

Then (/^I should add details about the comment/) do
  find('.comment-field').set('truly funny')
  click_button('Comment')
end

Then (/^I should be able to view the comment/) do
  expect(page).to have_content('truly funny')
end