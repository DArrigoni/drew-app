require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.strategy = :truncation

Around do |_, block|
  DatabaseCleaner.cleaning(&block)
end