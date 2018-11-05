Given(/^I have not signed up$/) do
  #No-OP
end

When(/^I go to the app$/) do
  visit('http://localhost:8000/tasks')
end

Then(/^I should see the landing page$/) do
  expect(page).to have_selector('#login')
end

When(/^I click log in$/) do
  click_on('Log in')
end

And(/^I sign in with the email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  fill_in(:email, with: email)
  fill_in(:password, with: password)
  page.find('.auth0-lock-submit').click
end

Then(/^I should see the dashboard$/) do
  expect(page).to have_content('Dashboard')
end