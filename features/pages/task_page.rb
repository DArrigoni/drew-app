class TaskPage
  include Capybara::DSL

  def description
    within '#task' do
      find('.description').text
    end
  end
end