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

When(/^I mark the first task as done$/) do
  within('#tasks li:first-of-type') do
    click_on 'task_mark_done'
  end
end

Then(/^I should see my tasks$/) do
  expect(page).to have_css('#tasks li', count: 5)
end

Then(/^the first task should be "([^"]*)"$/) do |task_name|
  expect(page.find('#tasks li')).to have_content(task_name)
end

Then(/^I should see (\d+) tasks?$/) do |count|
  expect(page).to have_css('#tasks li', count: count)
end

Then(/^the form should be reset$/) do
  expect(page.find('input[name="task_title"]').value).to eq ''
end

Then(/^I should see (\d+) done tasks?$/) do |count|
  expect(page).to have_css('#tasks li.task--done', count: count)
end
