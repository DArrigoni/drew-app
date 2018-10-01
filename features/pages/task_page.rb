class TaskPage
  include Capybara::DSL

  def description
    scoped do
      find('.description').text
    end
  end

  def start_edit
    scoped do
      find('#task__edit').click
    end
  end

  def set_title task_title
    scoped do
      fill_in 'title', with: task_title
    end
  end

  def save_changes
    scoped do
      click_on 'Save'
    end
  end

  def title_has_focus?
    scoped do
      has_css?('#task__edit-form input[name="title"]:focus')
    end
  end

  private

  def scoped
    within '#task' do
      yield
    end
  end
end 