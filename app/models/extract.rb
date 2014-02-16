require 'csv'
require 'open-uri'

class Extract

  def self.run
    new.run
  end

  def run
    quakes.each do |row|
      Earthquake.find_or_create_by_quake_id(change_names(row)) 
    end
  end
  
  private 

  def quakes
    quakes = CSV.parse(open(uri).read, headers: true, header_converters: :symbol)
  end

  def uri
    URI("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv")
  end

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
end