require 'spec_helper'

describe Earthquake do
 describe 'default scope' do
    it 'should only show last 7 days data' do
      Earthquake.all.to_sql.should match(/quake_date['"]? >= '?#{7.days.ago.to_date}/)
    end
  end
end
