Given(/^I have some tasks$/) do
  load_fixture
end

Given(/^there are no tasks$/) do
end

Given(/^I have some mixed tasks$/) do
  load_fixture('mixed')
end

Given(/^I am on the task page$/) do
  step('I goto the task page')
end

Given(/^the first task has been started$/) do
  step('I start the first task')
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
    click_on 'Done'
  end
end

When(/^I filter in done tasks$/) do
  check 'Show done'
end

When(/^I start the first task$/) do
  within('#tasks li:first-of-type') do
    click_on 'Start'
  end
end

When(/^I stop the first task$/) do
  within('#tasks li:first-of-type') do
    click_on 'Stop'
  end
end

Then(/^I should see my tasks$/) do
  step('I should see 5 tasks')
end

Then(/^the first task should be "([^"]*)"$/) do |task_name|
  expect(page.find('#tasks li')).to have_content(task_name)
end

Then(/^I should see (\d+) tasks?$/) do |count|
  expect(page).to have_css('#tasks li.task-list-item', count: count)
end

Then(/^the form should be reset$/) do
  expect(page.find('input[name="task_title"]').value).to eq ''
end

Then(/^I should see (\d+) done tasks?$/) do |count|
  expect(page).to have_css('#tasks li.task-list-item.done', count: count)
end


Then(/^I should see (\d+) started tasks?$/) do |count|
  expect(page).to have_css('#tasks li.task-list-item.started', count: count)
end