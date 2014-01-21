class Earthquake < ActiveRecord::Base
  attr_accessible :quake_date, :latitude, :longitude,:depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :quake_id, :updated, :place

  ALL_EARTHQUAKES = :quake_id, :latitude, :longitude,:depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :quake_date, :updated, :place
  
  default_scope -> { where arel_table[:quake_date].gteq(7.days.ago) }
  
  scope :all_quakes, -> { select(ALL_EARTHQUAKES) }
  scope :on_day, -> (date) { where Arel::Nodes::NamedFunction.new(:date, [arel_table[:quake_date]]).eq(date) }
  scope :since_quake, -> (time) { where arel_table[:quake_date].gt(time) }
  scope :mag_over, -> (mag) { where arel_table[:mag].gt(mag) }
  scope :near, -> (lat, long) {
    where('earth_box(ll_to_earth(?, ?), 8047) @> ll_to_earth(latitude, longitude)', lat, long).
      where('earth_distance(ll_to_earth(?,?), ll_to_earth(latitude,longitude)) < 8047', lat, long)
  }
end