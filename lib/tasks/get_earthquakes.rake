require 'csv'
require 'net/http'

desc 'Get Earthquake CSV'

task :get_earthquakes => :environment do
  puts "Getting earthquakes"
  uri = URI("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv")
  page = Net::HTTP.get(uri)
  
  File.open("earthquakes.csv", "w") do |f|
    f << page
  end

  puts "Creating earthquake objects"
  CSV.foreach("earthquakes.csv", headers: true, header_converters: :symbol) do |row|

    def change_names(row)
      {
        quake_date: row[:time],
        latitude: row[:latitude],
        longitude: row[:longitude],
        depth: row[:depth],
        mag: row[:mag],
        magtype: row[:magtype],
        nst: row[:nst],
        gap: row[:gap],
        dmin: row[:dmin],
        rms: row[:rms],
        net: row[:net],
        quake_id: row[:id],
        updated: row[:updated],
        place: row[:place]
      }
    end

    # binding.pry
    print '.'
    Earthquake.create(change_names(row)) 
  end
end

