def trackers_page
  @trackers_page ||= TrackersPage.new
end

def tracker_new_page
  @tracker_new_page ||= TrackerNewPage.new
end

def tracker_page
  @tracker_page ||= TrackerPage.new
end

Given(/^I have no trackers$/) do
  # No-Op
end

Given(/^I have a tracker named "([^"]*)"(?: with (no|\d+) records)?$/) do |title, a|
  tracker_new_page.visit_page
  tracker_new_page.set_title(title)
  tracker_new_page.save

  count = a.to_i
  if count > 0
    trackers_page.tracker_for(title).open_detail

    count.times { tracker_page.add_record }
  end
end

Given(/^I am on the tracker page for "([^"]*)"$/) do |title|
  trackers_page.visit_page
  trackers_page.tracker_for(title).open_detail
end

When(/^I (?:go to|am on) the trackers page$/) do
  trackers_page.visit_page
end

When(/^I click the new Tracker button$/) do
  click_on 'New Tracker'
end

When(/^I add the title "([^"]*)"$/) do |title|
  tracker_new_page.set_title(title)
end

When(/^I save my new tracker$/) do
  tracker_new_page.save
end

When(/^I add a tracker record$/) do
  tracker_page.add_record
end

When(/^I click on the tracker named "([^"]*)"$/) do |title|
  trackers_page.tracker_for(title).open_detail
end

When(/^I delete the tracker$/) do
  tracker_page.delete
end

When(/^I cancel out of the tracker delete warning$/) do
  tracker_page.cancel_delete
end

When(/^I agree to the tracker delete warning$/) do
  tracker_page.confirm_delete
end

Then(/^I should see (\d+) trackers?$/) do |count|
  expect(trackers_page).to be_current_page

  count = count.to_i

  if count == 0
    expect(current_page).to have_no_trackers
  else
    expect(current_page).to have_tracker_count_of count
  end
end

Then(/^I should be on the create tracker page$/) do
  expect(tracker_new_page).to be_current_page
end

Then(/^I should be on the trackers page$/) do
  expect(trackers_page).to be_current_page
end

Then(/^I should be on the tracker page for "([^"]*)"$/) do |title|
  expect(tracker_page).to be_current_page
  expect(tracker_page.title).to eq title
end

Then(/^I should see a tracker titled "([^"]*)"$/) do |title|
  expect(trackers_page.tracker_for(title)).to be_present
end

Then(/^I should see no tracker records$/) do
  expect(current_page).to have_no_tracker_records
end

Then(/^I should see (\d+) tracker record(?:s)?$/) do |count|
  expect(current_page).to have_tracker_record_count_of count
end

Then(/^I should see a tracker record for today$/) do
  expect(tracker_page.tracker_records.any? { |tracker_record| tracker_record.record_time.to_date == Date.current }).to be true
end

Then(/^I should see a warning about deleting records$/) do
  expect(tracker_page).to have_tracker_delete_warning_visible
end