require 'spec_helper'

describe Earthquake do
  describe 'default scope' do
    it 'should only show last 7 days data' do
      Earthquake.all.to_sql.should match(/quake_date['"]? >= '?#{7.days.ago.to_date}/)
    end

  describe '.on_day(date)' do
    it 'should select only those where quake_date lies within date given' do
      today = Date.today
      Earthquake.unscoped.on_date(today).to_sql.should match(/date\(.*quake_date.*\) = '#{today.to_s(:db)}'/)
    end
  end 

  
end


end
