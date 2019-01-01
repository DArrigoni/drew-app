require_relative 'test_page_object'

class TestPage < TestPageObject
  TEST_HOST = 'http://localhost:8000'

  def page_root
    "##{identifier}"
  end

  def url_path
    "/#{identifier}"
  end

  def element
    @element ||= page.find(page_root)
  end

  def visit_page
    visit("#{TEST_HOST}#{url_path}")
  end

  def current_page?
    page.has_current_path?(url_path)
  end

  private

  def identifier
    self.class.name.gsub('Page', '').underscore.dasherize
  end
end
