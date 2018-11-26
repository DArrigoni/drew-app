Given(/^I have not signed up$/) do
  #No-OP
end

Given(/^I have logged in$/) do
  visit 'http://localhost:8000/login'
  click_on 'Log in'

  if page.has_css?('.auth0-lock-last-login-pane')
    page.find('.auth0-lock-alternative-link').click
  end

  fill_in :email, with: 'bob@bob.bob'
  fill_in :password, with: 'Password123'
  page.find('.auth0-lock-submit').click

  expect(page).to have_content('Dashboard')
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

Given(/^the user Bob exists$/) do
  load_fixture('bob_user')
end