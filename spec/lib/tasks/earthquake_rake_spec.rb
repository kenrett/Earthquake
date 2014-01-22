require 'spec_helper'
require 'csv'
require 'rake'

describe 'rake get_earthquakes' do

  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    # Rake.application.rake_require "/get_earthquakes"
    Rake::Task.define_task(:environment)
  end

  let :run_rake_task do
    Rake::Task.define_task("now:get_earthquakes")
    Rake::Task["now:get_earthquakes"].reenable
    Rake::Task["now:get_earthquakes"].invoke
  end

  describe "csv creation" do
    let(:data) { "title\tsurname\tfirstname\rtitle2\tsurname2\tfirstname2\r"}
    let(:result) {[["title","surname","firstname"],["title2","surname2","firstname2"]] }

    it "should parse file contents and return a result" do
      File.stub(:open).with("filename","rb") { data }
      data.split.should eq(result.flatten)
    end
  end

  describe 'when change_names(row) is called' do
    it 'changes the name of the keys' do

      prerow = pre_conversion_row

      row = change_names(prerow)

      expect(row) == change_names(prerow)
    end
  end
end

def converted_row
  row = {
    quake_id: 'nc12345678', latitude: 12.3456, longitude: -123.456, depth: 1.2, mag: 1.2, magtype: "Md", nst: 1, gap: 12, dmin: 1, rms: 1, net: "nc", quake_date: Date.parse('2014-01-01 00:12:34'), updated: Date.parse('2014-01-01 00:23:34'), place: "5km W of Walnut Creek, CA"
  }
end

def pre_conversion_row
  row = { id: "nc12345671", latitude: "12.3456", longitude: "-123.456", depth: "1.2", mag: "1.2", magtype: "Md", nst: "1", gap: "12", dmin: "1", rms: "1", net: "nc", time: '2014-01-01 00:12:34', updated: '2014-01-01 00:23:34', place: "5km W of Walnut Creek, CA" }
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