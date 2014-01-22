# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :earthquake do
    quake_date { Time.at rand(7.days.ago.to_i..DateTime.now.to_i) }
    latitude { Faker::Geolocation.lat }
    longitude { Faker::Geolocation.lng }
    sequence(:depth) { |i| "11#{i}" }
    sequence(:mag) { |i| "#{rand(1...8)}.#{i}" }
    magtype 'za'
    sequence(:nst) { |i| "22#{i}" }
    sequence(:gap) { |i| "33#{i}" }
    sequence(:dmin) { |i| "44#{i}" }
    sequence(:rms) { |i| "55#{i}" }
    sequence(:net) { |i| "66#{i}" }
    sequence(:quake_id) { |i| "nc1234567#{i}" }
    updated { Time.at rand(7.days.ago.to_i..DateTime.now.to_i) }
    sequence(:place) { |i| "place #{i}" }
  end
end
