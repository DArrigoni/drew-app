class TrackersPage < TestPage
  def self.selector
    'li.tracker-list-item'
  end

  def self.descriptor
    'tracker'
  end

  def add_new_task title:
    scoped do
      fill_in('task-input', with: title)
      click_on 'Save'
    end
  end

  def trackers
    scoped do
      find_all(TrackersPage.selector).map { |elem| TrackerListItem.new(elem) }
    end
  end

  def tracker_for title
    scoped do
      trackers.find { |tracker| tracker.title == title }
    end
  end

  private

  class TrackerListItem < TestPageObject
    def title
      element.text
    end

    def open_detail
      element.click
    end
  end
end


class TrackerPage < TestPage
  attr_accessor :id

  def self.record_selector
    'li.tracker-record-list-item'
  end

  def self.record_descriptor
    'tracker records'
  end

  def current_page?
    /\/trackers\/\d+/ =~ page.current_path
  end

  def title
    scoped do
      page.find('#tracker__details h2').text
    end
  end

  def add_record
    scoped do
      page.find('#tracker__actions-add-record').click
    end
  end

  def tracker_records
    scoped do
      find_all(TrackerPage.record_selector).map { |elem| TrackerRecordListitem.new(elem) }
    end
  end

  def delete
    scoped do
      page.find('#tracker__delete').click
    end
  end

  def cancel_delete
    scoped do
      page.find('#tracker_delete__cancel').click
    end
  end

  def confirm_delete
    scoped do
      page.find('#tracker_delete__confirm').click
    end
  end

  private

  class TrackerRecordListitem < TestPageObject
    def record_time
      scoped do
        Time.strptime(find('.record-time').text, '%m/%d/%Y, %r')
      end
    end
  end
end

class TrackerNewPage < TestPage

  def url_path
    '/trackers/new'
  end

  def set_title title
    scoped do
      fill_in 'title', with: title
    end
  end

  def save
    scoped do
      click_on 'Save'
    end
  end
end

RSpec::Matchers.define :have_no_trackers do
  match do |_|
    !page.has_css?(TrackersPage.selector)
  end

  failure_message do |_|
    selector = TrackersPage.selector
    actual_count = page.all(selector).count
    descriptor = TrackersPage.descriptor

    "Expected to find no instances of #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end

RSpec::Matchers.define :have_tracker_count_of do |count, qualities|
  match do |_|
    raise ArgumentError.new("Expected count to be > 0") if count <= 0

    page.has_css?(TrackersPage.selector, count: count)
  end

  failure_message do |_|
    selector = TrackersPage.selector
    actual_count = page.all(selector).count
    descriptor = TrackersPage.descriptor

    "Expected to find #{count} instances of #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end

RSpec::Matchers.define :have_no_tracker_records do
  match do |_|
    !page.has_css?(TrackerPage.record_selector)
  end

  failure_message do |_|
    selector = TrackerPage.record_selector
    actual_count = page.all(selector).count
    descriptor = TrackerPage.record_descriptor

    "Expected to find no instances of #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end

RSpec::Matchers.define :have_tracker_record_count_of do |count, qualities|
  match do |_|
    raise ArgumentError.new("Expected count to be > 0") if count <= 0

    page.has_css?(TrackerPage.record_selector, count: count)
  end

  failure_message do |_|
    selector = TrackerPage.record_selector
    actual_count = page.all(selector).count
    descriptor = TrackerPage.record_descriptor

    "Expected to find #{count} instances of #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end

RSpec::Matchers.define :have_tracker_delete_warning_visible do
  match do |_|
    page.has_css?('#tracker_delete')
  end

  failure_message do |_|
    "Tracker delete confirmation not open"
  end
end