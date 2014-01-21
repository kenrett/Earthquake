class EarthquakeSerializer < ActiveModel::Serializer
  attributes :quake_id, :latitude, :longitude,:depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :quake_date, :updated, :place
end
