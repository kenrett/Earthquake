require 'csv'
require 'net/http'

# puts 'here I am!'

desc 'Get Earthquake CSV'

namespace :now do
  task :get_earthquakes => :environment do
    puts "Getting earthquakes"
    uri = URI("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv")
    page = Net::HTTP.get(uri)

    File.open("earthquakes.csv", "w") do |f|
      f << page
    end

    total = Earthquake.all.count
    puts "Creating earthquake objects, there are currently #{total} earthquakes."
    CSV.foreach("earthquakes.csv", headers: true, header_converters: :symbol) do |row|
    # binding.pry
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
      puts "HERE!"
    Earthquake.find_or_create_by_quake_id(change_names(row)) 
    puts "There are now #{Earthquake.all.count} earthquakes."
    end
    # binding.pry
  end
end
