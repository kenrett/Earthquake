require 'spec_helper'

describe Earthquake do
  describe 'default scope' do
    it 'should only show last 7 days data' do
      Earthquake.all.to_sql.should match(/quake_date['"]? >= '?#{7.days.ago.to_date}/)
    end

  describe '.on_day(date)' do
    it 'should select only those where quake_date lies within date given' do
      today = Date.today
       Earthquake.unscoped.on_day(today).to_sql.should match(/date\(.*quake_date.*\) = '#{today.to_s(:db)}'/)
    end
  end 

  describe '.since_quake(quake_date)' do
    it 'should select all quakes since the date given' do
      time = 1.hour.ago
      Earthquake.unscoped.since_quake(time).to_sql.should match(/quake_date['"]? > '?#{time.to_s(:db)}/)  
    end
  end

end


end
