class TestPageObject
  include Capybara::DSL

  TEST_HOST = 'http://localhost:8000'

  attr_accessor :element, :parent

  def initialize element, parent = nil
    self.element = element
    self.parent = parent
  end

  def url_path
    if parent.present?
      parent.url_path
    else
      raise NotImplementedError.new('Must define URL path')
    end
  end

  def visit_page
    visit("#{TEST_HOST}#{url_path}")
  end

  def current_page?
    page.has_current_path?(url_path)
  end

  def scoped &block
    within element do
      yield
    end
  end
end
