require 'webmock'
include WebMock::API

FactoryGirl.define do

  factory :usgs_api do
    skip_create

    ignore do
      data_url "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv"
      data { quake_id: 'nc12345678', latitude: 12.3456, longitude: -123.456, depth: 1.2, mag: 1.2, magtype: "Md", nst: 1, gap: 12, dmin: 1, rms: 1, net: "nc", quake_date: Date.parse('2014-01-01 00:12:34'), updated: Date.parse('2014-01-01 00:23:34'), place: "5km W of Walnut Creek, CA" }
    end

    initialize_with do
      stub_request(:get, data_url).to_return(body: data)
      new(data_url)
    end
  end
end