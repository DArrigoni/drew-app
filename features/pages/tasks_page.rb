require 'rspec/expectations'

class TasksPage
  include Capybara::DSL

  def visit_page
    visit('http://localhost:8000/tasks')
  end

  def add_new_task title:
    fill_in(:task_title, with: title)
    click_on 'Save'
  end

  def tasks
    find_all('#tasks li.task-list-item').map { |elem| TaskListItem.new(elem) }
  end

  def task_for title
    tasks.find { |task| task.title == title }
  end

  def toggle_show_done_filter
    check 'Show done'
  end

  def new_task_input
    find('input[name="task_title"]')
  end
end

RSpec::Matchers.define :have_task_count_of do |count, qualifier|
  match do |_|
    selector = case qualifier&.strip
               when 'done'    then '#tasks li.task-list-item.done'
               when 'started' then '#tasks li.task-list-item.started'
               else                '#tasks li.task-list-item'
               end

    has_css?(selector, count: count)
  end
end

class TaskListItem
  include Capybara::DSL

  attr_accessor :element

  def initialize element
    self.element = element
  end

  def title
    element.find('.title').text
  end

  def mark_done
    within element do
      click_on 'Done'
    end
  end

  def start
    within element do
      click_on 'Start'
    end
  end

  def stop
    within element do
      click_on 'Stop'
    end
  end
end

RSpec::Matchers.define :be_started do
  match do |task_list_item|
    task_list_item.element.matches_css?('.started')
  end
end

