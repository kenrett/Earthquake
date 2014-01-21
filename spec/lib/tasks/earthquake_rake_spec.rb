require 'spec_helper'
require 'csv'
require 'rake'

describe 'get_earthquakes' do

  before :all do
    Rake.application = Rake::Application.new
    Rake.application.rake_require "tasks/get_earthquakes"
    Rake::Task.define_task(:environment)
  end

  let :run_rake_task do
    Rake::Task["get_earthquakes"].reenable
    Rake.application.invoke_task("get_earthquakes")
  end

  it 'creates an earthquake' do

    # binding.pry
    row = mock_csv_row
    CSV.stub(:foreach).and_yield row

    earthquake.create(mock_csv_row) #need to create an earthquake somehow....?!

    run_rake_task

    quake = Earthquake.first

    puts quake.quake_id
    # expect(quake.quake_id).to eq row[:quake_id]
    # expect(quake.latitude).to eq row[:latitude]
    # expect(quake.longitude).to eq row[:longitude]
    # expect(quake.depth).to eq row[:depth]
    # expect(quake.magtype).to eq row[:magtype]
    # expect(quake.updated).to eq row[:updated]
  end
end

def mock_csv_row
  row = {
    quake_id: 'nc12345678', latitude: 12.3456, longitude: -123.456, depth: 1.2, mag: 1.2, magtype: "Md", nst: 1, gap: 12, dmin: 1, rms: 1, net: "nc", quake_date: DateTime.new('2014-01-01 00:12:34'), updated: DateTime.new('2014-01-01 00:23:34'), place: "5km W of Walnut Creek, CA"
  }
end