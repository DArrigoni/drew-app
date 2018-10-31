require 'rspec/expectations'

class TasksPage
  include Capybara::DSL

  def visit_page
    visit('http://localhost:8000/tasks')
  end

  def add_new_task title:
    scoped do
      fill_in(:task_title, with: title)
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

  def toggle_show_done_filter
    scoped do
      check 'Show done'
    end
  end

  def toggle_focus_started_tasks_filter
    scoped do
      check 'Focus started'
    end
  end

  def new_task_input
    scoped do
      find('input[name="task_title"]')
    end
  end

  private

  def scoped
    within '#tasks' do
      yield
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

    def open_detail
      element.click
    end
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

RSpec::Matchers.define :be_started do
  match do |task_list_item|
    task_list_item.element.matches_css?('.started')
  end
end

