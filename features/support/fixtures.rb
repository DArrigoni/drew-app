require 'active_record'
require 'active_record/fixtures'
require 'active_support'


# Setup database connection
ActiveRecord::Base.establish_connection({ "adapter"=>"postgresql",
                                          "encoding"=>"unicode",
                                          "pool"=>"5",
                                          "database"=>"drew-app_test"})

Before do
  ActiveRecord::FixtureSet.reset_cache
  fixtures_folder = File.join('./features/support/fixtures/')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
end

