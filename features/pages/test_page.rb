require_relative 'test_page_object'

class TestPage < TestPageObject

  def initialize
    super(nil)
  end

  def page_root
    "##{self.class.name.gsub('Page', '').downcase}"
  end

  def url_path
    "/#{self.class.name.gsub('Page', '').downcase}"
  end

  def element
    @element ||= page.find(page_root)
  end
end
