def tasks_page
  @tasks_page ||= TasksPage.new
end

def task_page
  @task_page ||= TaskPage.new
end

def dashboard_page
  @dashboard_page ||= DashboardPage.new
end

def current_page
  return task_page if task_page.current_page?
  return tasks_page if tasks_page.current_page?
  return dashboard_page if dashboard_page.current_page?
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

Given(/^I am on the dashboard page$/) do
  dashboard_page.visit_page
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
  tasks_page.enable_focus_started_tasks_filter
end

When(/^I reset the started filter for tasks$/) do
  tasks_page.disable_focus_started_tasks_filter
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

When(/^I click the "([^"]*)" tag$/) do |tag|
  tasks_page.click_first_task_tag_for tag
end

When(/^I clear the tag filter$/) do
  tasks_page.clear_task_filter
end

Then(/^I should see my tasks$/) do
  expect(current_page).to have_task_count_of 5
end

Then(/^the first task should be "([^"]*)"$/) do |title|
  expect(tasks_page.tasks.first.title).to eq(title)
end

When(/^I change the description to$/) do |description|
  task_page.set_description description
end

When (/^I go to the tasks page$/) do
  tasks_page.visit_page
end

Then(/^I should see (\d+)( done| started)? tasks?( on the dashboard| on the tasks page)?$/) do |count, qualifier, page|
  if page&.include?('dashboard')
    expect(dashboard_page).to be_current_page
  else
    expect(tasks_page).to be_current_page
  end

  expect(current_page).to have_task_count_of count, qualifier
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

Then(/^I should see (\d+) task(?:s)? tagged as "([^"]*)"$/) do |count, tag|
  expect(tasks_page).to have_task_count_of(count, {tag: tag})
end

Then(/^I should see the description$/) do |description|
  expect(page.text).to include(description)
end