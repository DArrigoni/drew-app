class TestPageObject
  include Capybara::DSL

  attr_accessor :element, :parent

  def initialize element = nil, parent = nil
    self.element = element
    self.parent = parent
  end

  def scoped &block
    within element do
      yield
    end
  end
end
