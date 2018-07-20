require 'active_record'
require 'active_record/fixtures'
require 'active_support'


# Setup database connection
ActiveRecord::Base.establish_connection({ "adapter"=>"postgresql",
                                          "encoding"=>"unicode",
                                          "pool"=>"5",
                                          "database"=>"drew-server_test"})

Before do

end

