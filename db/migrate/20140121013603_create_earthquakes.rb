class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes, :id=> false do |t|
      t.datetime   :quake_date, :updated
      t.float      :latitude, :longitude, :depth, :mag
      t.integer    :gap, :nst, :dmin, :rms
      t.string     :magtype, :net, :quake_id, :place, :type
    end
  end
end
