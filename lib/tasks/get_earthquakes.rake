require 'csv'
require 'net/http'

desc 'Get Earthquake CSV'

namespace :now do
  task :get_earthquakes => :environment do
    
    Extract.new.run
    # binding.pry
  end
end
