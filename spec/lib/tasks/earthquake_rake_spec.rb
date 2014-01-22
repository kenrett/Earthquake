require 'spec_helper'
require 'csv'
require 'rake'

describe 'rake get_earthquakes' do

  before :all do
    # Rake.application.rake_require "tasks/get_earthquakes"
    Rake::Task.define_task(:environment)
  end

  let :run_rake_task do
    # binding.pry
    Rake::Task.define_task("now:get_earthquakes")
    Rake::Task["now:get_earthquakes"].reenable
    Rake::Task["now:get_earthquakes"].invoke
  end

  it 'creates an earthquake' do

    row = pre_conversion_row
    CSV.stub(:foreach).and_yield row

    # binding.pry
    run_rake_task
    # binding.pry
    quake = FactoryGirl.create(:earthquake)

    puts quake.quake_id
    expect(quake.quake_id).to eq row[:quake_id]
    expect(quake.latitude).to eq row[:latitude]
    expect(quake.longitude).to eq row[:longitude]
    expect(quake.depth).to eq row[:depth]
    expect(quake.magtype).to eq row[:magtype]
    expect(quake.updated).to eq row[:updated]
  end

  describe 'when change_names(row) is called' do
    it 'changes the name of the keys' do

      row = converted_row
      CSV.stub(:foreach).and_yield row

      
      # let(:quake) = { FactoryGirl.create(:earthquake) }
      
      # expect(quake[:quake_id]).to eq('MZKXSCCG')
      # expect(quake[:quake_date]).to eq(Date.parse('2014-01-01 00:12:34'))
      # expect(quake[:latitude]).to eq(12.3456)
      # expect(quake[:longitude]).to eq(-123.456)
      # expect(quake[:depth]).to eq(1.2)
      # expect(quake[:nst]).to eq(1)
      # expect(quake[:region]).to eq("5km W of Walnut Creek, CA")
    end
  end
end

def converted_row
  row = {
    quake_id: 'nc12345678', latitude: 12.3456, longitude: -123.456, depth: 1.2, mag: 1.2, magtype: "Md", nst: 1, gap: 12, dmin: 1, rms: 1, net: "nc", quake_date: Date.parse('2014-01-01 00:12:34'), updated: Date.parse('2014-01-01 00:23:34'), place: "5km W of Walnut Creek, CA"
  }
end

def pre_conversion_row
  row = { id: "nc12345678", latitude: "12.3456", longitude: "-123.456", depth: "1.2", mag: "1.2", magtype: "Md", nst: "1", gap: "12", dmin: "1", rms: "1", net: "nc", time: '2014-01-01 00:12:34', updated: '2014-01-01 00:23:34', place: "5km W of Walnut Creek, CA" }
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