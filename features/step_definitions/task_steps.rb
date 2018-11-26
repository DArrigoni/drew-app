def tasks_page
  @tasks_page ||= TasksPage.new
end

def task_page
  @task_page ||= TaskPage.new
end

Given(/^I have some tasks$/) do
  load_fixture
end

Given(/^there are some tasks$/) do
  load_fixture
end

Given(/^there are no tasks$/) do
end

Given(/^I have some mixed tasks$/) do
  load_fixture('mixed')
end

Given(/^I (?:am on|go to) the task page$/) do
  tasks_page.visit_page
end

Given(/^the first task has been started$/) do
  step('I start the first task')
end

Given(/^I have added the task "([^"]*)"$/) do |task_title|
  tasks_page.visit_page
  tasks_page.add_new_task(title: task_title)
  tasks_page.visit_page
end

Given(/^the "([^"]*)" task has been started$/) do |task_title|
  tasks_page.visit_page
  tasks_page.task_for(task_title).start
end

Given(/^I am on the details page for first task$/) do
  tasks_page.visit_page
  tasks_page.tasks.first.open_detail
end

When(/^I add a task for "([^"]*)"$/) do |task_title|
  tasks_page.add_new_task(title: task_title)
end

When(/^I mark the first task as done$/) do
  tasks_page.tasks.first.mark_done
end

When(/^I filter in done tasks$/) do
  tasks_page.toggle_show_done_filter
end

When(/^I filter for started tasks$/) do
  tasks_page.toggle_focus_started_tasks_filter
end

When(/^I start the(?: first)? task$/) do
  tasks_page.tasks.first.start
end

When(/^I start the "([^"]*)" task/) do |task_title|
  tasks_page.task_for(task_title).start
end

When(/^I stop the(?: first)? task$/) do
  tasks_page.tasks.first.stop
end

When(/^I go off and do some work then return$/) do
  page.refresh
end

When(/^I open the details of the first task$/) do
  tasks_page.tasks.first.open_detail
end

When(/^I click the edit button$/) do
  task_page.start_edit
end

When(/^I change the title to "([^"]*)"$/) do |task_title|
  task_page.set_title task_title
end

When(/^I save my changes$/) do
  task_page.save_changes
end

Then(/^I should see my tasks$/) do
  expect(tasks_page).to have_task_count_of 5
end

Then(/^the first task should be "([^"]*)"$/) do |title|
  expect(tasks_page.tasks.first.title).to eq(title)
end

Then(/^I should see (\d+)( done| started)? tasks?$/) do |count, qualifier|
  expect(tasks_page).to be_current_page
  expect(tasks_page).to have_task_count_of count, qualifier
end

Then(/^the form should be reset$/) do
  expect(tasks_page.new_task_input.value).to eq ''
end

Then(/^I should see the "([^"]*)" task is( no longer)? started$/) do |title, negation|
  task_list_item = tasks_page.task_for(title)

  if negation.present?
    expect(task_list_item).to_not be_started
  else
    expect(task_list_item).to be_started
  end
end

Then(/^I should( not)? see a task for "([^"]*)"$/) do |negation, title|
  if negation
    expect(tasks_page.task_for(title)).to_not be_present
  else
    expect(tasks_page.task_for(title)).to be_present
  end
end

Then(/^I should see the first task's description$/) do
  expect(task_page.description).to be_present
end

Then(/^I should be ready to edit the task$/) do
  expect(task_page.title_has_focus?).to be true
end
