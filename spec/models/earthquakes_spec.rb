require 'spec_helper'

describe Earthquake do
    
  describe 'validations' do
  quake = FactoryGirl.build(:earthquake)
    binding.pry
    it { should validate_uniqueness_of :quake_id }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :mag }
    it { should validate_presence_of :nst }
    it { should validate_presence_of :depth }
  end

  describe 'default scope' do
  

    it 'should only show last 7 days data' do
      Earthquake.all.to_sql.should match(/quake_date['"]? >= '?#{7.days.ago.to_date}/)
    end
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

  describe '.mag_over(float)' do
    it 'should select only quakes over magnitude given' do
      Earthquake.unscoped.mag_over(3.4).to_sql.should match(/mag['"]? > ? 3.4/)
    end
  end

  describe '.near(lat, long)' do
    it 'should return earthquakes within 5 miles' do
      pending # would love to learn how to test this!
      Earthquake.unscoped.near(19.4688, -155.9172).to_sql.should 
    end
  end
end