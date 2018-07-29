Given(/^I have some tasks$/) do
  load_fixture
end

Given(/^there are no tasks$/) do
end

When(/^I goto the task page$/) do
  visit('http://localhost:8000/tasks')
end

When(/^I add a task for "([^"]*)"$/) do |task_title|
  fill_in(:task_title, with: task_title )
  click_on('Save')
end

Then(/^I should see my tasks$/) do
  expect(page).to have_css('#tasks li', count: 5)
end

Then(/^the first task should be "([^"]*)"$/) do |task_name|
  expect(page.find('#tasks li')).to have_content(task_name)
end

Then(/^I should see (\d+) task$/) do |count|
  expect(page).to have_css('#tasks li', count: count)
end