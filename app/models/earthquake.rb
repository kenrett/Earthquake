class Earthquake < ActiveRecord::Base
  attr_accessible :quake_date, :latitude, :longitude,:depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :quake_id, :updated, :place

  ALL_EARTHQUAKES = :quake_id, :latitude, :longitude,:depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :quake_date, :updated, :place
  
  default_scope -> { where arel_table[:quake_date].gteq(7.days.ago) }
  scope :all_quakes, -> { select(ALL_EARTHQUAKES) }
end