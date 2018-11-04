Given(/^I have not signed up$/) do
  #No-OP
end

When(/^I go to the app$/) do
  visit('http://localhost:8000/tasks')
end

Then(/^I should see the landing page$/) do
  expect(page).to have_selector('#login')
end

When(/^I click sign up$/) do
  click_on('Log in')
end

And(/^I sign up with the email "([^"]*)"$/) do |arg|
  binding.pry
end

Then(/^I should see the dashboard$/) do
  expect(page).to have_content('Dashboard')
end