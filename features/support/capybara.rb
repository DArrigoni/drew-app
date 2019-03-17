require 'capybara/cucumber'
require 'chromedriver-helper'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome,
    driver_opts: { log_path: 'out/chromedriver.out' }
  )
end

Capybara.default_driver = :chrome

