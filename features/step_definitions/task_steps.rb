Given(/^I have some tasks$/) do
  #No-op for now
end

When(/^I goto the task page$/) do
  visit('http://localhost:8000/tasks')
end

Then(/^I should see my tasks$/) do
  expect(page).to have_css('#tasks li', count: 5)
end