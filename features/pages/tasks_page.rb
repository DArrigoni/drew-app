require 'rspec/expectations'
require_relative 'test_page'

class TasksPage < TestPage
  def self.selector(qualities)
    item_classes = []
    tag_name = nil

    qualities.each do |k, v|
      if k == 'tag'
        item_classes << 'tagged'
        tag_name = v.strip
      elsif v == true
        item_classes << k.strip
      end
    end

    selector = "li.task-list-item"
    selector += ".#{item_classes.join('.')}" if item_classes.present?
    selector += " .tag[data-tag-name='#{tag_name}']" if tag_name.present?

    return selector
  end

  def self.descriptor(qualities)
    item_classes = []
    tag_name = nil

    qualities.each do |k, v|
      if k == 'tag'
        item_classes << 'tagged'
        tag_name = v.strip
      elsif v == true
        item_classes << k.strip
      end
    end

    descriptor = ''
    descriptor += (item_classes.join(', ') + ' ') if item_classes.present?
    descriptor += 'tasks'
    descriptor += " tagged with #{tag_name}" if tag_name.present?

    return descriptor
  end

  def add_new_task title:
    scoped do
      fill_in('task-input', with: title)
      click_on 'Save'
    end
  end

  def tasks
    scoped do
      find_all('li.task-list-item').map { |elem| TaskListItem.new(elem, self) }
    end
  end

  def task_for title
    tasks.find { |task| task.title == title }
  end

  def click_first_task_tag_for tag_name
    scoped do
      first(".tag[data-tag-name='#{tag_name}']").click
    end
  end

  def toggle_show_done_filter
    scoped do
      check 'Show done'
    end
  end

  def enable_focused_tasks_filter
    scoped do
      check 'Focused'
    end
  end

  def disable_focused_tasks_filter
    scoped do
      uncheck 'Focused'
    end
  end

  def new_task_input
    scoped do
      find('input[name="task-input"]')
    end
  end

  def clear_task_filter
    scoped do
      find('.clear-tag-filter').click
    end
  end

  private

  class TaskListItem < TestPageObject
    def title
      element.find('.title').text
    end

    def focused?
      element.matches_css?('.focused')
    end

    def tags
      scoped do
        find_all('.tag').map { |elem| TaskListItemTag.new(elem)}
      end
    end

    def sort_order
      parent.tasks.index { |task| task.element == self.element}
    end

    def mark_done
      scoped do
        find('button.mark-done').click
      end
    end

    def focus
      scoped do
        find('button.focus').click
      end
    end

    def unfocus
      scoped do
        find('button.unfocus').click
      end
    end

    def open_detail
      element.click
    end

    class TaskListItemTag < TestPageObject

      def name
        element.text
      end

      def apply_filter
        element.click
      end
    end
  end
end

RSpec::Matchers.define :have_no_tasks do |qualities|
  match do |_|
    selector = TasksPage.selector(qualities)

    !page.has_css?(selector)
  end

  failure_message do |_|
    selector = TasksPage.selector(qualities)
    actual_count = page.all(selector).count
    descriptor = TasksPage.descriptor(qualities)

    "Expected to find no #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end

RSpec::Matchers.define :have_task_count_of do |count, qualities|
  match do |_|
    raise ArgumentError.new("Expected count to be > 0") if count <= 0

    selector = TasksPage.selector(qualities)

    page.has_css?(selector, count: count)
  end

  failure_message do |_|
    selector = TasksPage.selector(qualities)
    actual_count = page.all(selector).count
    descriptor = TasksPage.descriptor(qualities)

    "Expected to find #{count} instances of #{descriptor}. Actually found #{actual_count} via #{selector}"
  end
end
