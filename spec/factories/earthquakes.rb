# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :earthquake do
    quake_date { Time.at rand(7.days.ago.to_i..DateTime.now.to_i) }
    latitude { Faker::Geolocation.lat }
    longitude { Faker::Geolocation.lng }
    depth { (rand * 300).round(1) }
    mag { rand(1...8).to_f }
    magtype { 'za' }
    nst { rand(200) }
    gap { rand(200) }
    dmin { rand(200) }
    rms { rand(200) }
    net { rand(200) }
    quake_id { (0...10).map { (65 + rand(26)).chr }.join }
    updated { Time.at rand(7.days.ago.to_i..DateTime.now.to_i) }
    place { |num| "place #{num}" }
  end
end
