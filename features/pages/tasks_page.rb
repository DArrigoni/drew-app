require 'rspec/expectations'
require_relative 'test_page'

class TasksPage < TestPage
  def add_new_task title:
    scoped do
      fill_in('task-input', with: title)
      click_on 'Save'
    end
  end

  def tasks
    scoped do
      find_all('li.task-list-item').map { |elem| TaskListItem.new(elem) }
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

  def enable_focus_started_tasks_filter
    scoped do
      check 'Focus started'
    end
  end

  def disable_focus_started_tasks_filter
    scoped do
      uncheck 'Focus started'
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

    def started?
      element.matches_css?('.started')
    end

    def tags
      scoped do
        find_all('.tag').map { |elem| TaskListItemTag.new(elem)}
      end
    end

    def mark_done
      scoped do
        click_on 'Done'
      end
    end

    def start
      scoped do
        click_on 'Start'
      end
    end

    def stop
      scoped do
        click_on 'Stop'
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

RSpec::Matchers.define :have_task_count_of do |count, qualifier|
  match do |_|
    if qualifier.is_a?(Hash) && qualifier.keys.first == :tag
      tag = qualifier[:tag]
      qualifier = 'tag'
    end
    selector = case qualifier&.strip
               when 'done'    then 'li.task-list-item.done'
               when 'started' then 'li.task-list-item.started'
               when 'tag'     then 'li.task-list-item.tagged'
               else                'li.task-list-item'
               end

    if count <= 0 # Asserting 0 count can result in a false positive via race condition
      !has_css?(selector)
    elsif tag.present?
      has_css?(selector, count: count) && has_css?("li.task-list-item .tag[data-tag-name='#{tag}']")
    else
      has_css?(selector, count: count)
    end

  end
end

