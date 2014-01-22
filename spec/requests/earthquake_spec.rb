require 'spec_helper'

describe "Earthquakes" do 
  describe "get /earthquakes.json" do

    let :earthquake { FactoryGirl.create(:earthquake) }
    context 'with no params' do

      expect(response).to be_success
      # expect(json['content']).to 
      expect(json['private_attr']).to eq(nil)

      end
    end

    context '?since=__', params: { since: 30.minutes.ago.to_i } do
      let(:time) { Time.zone.at(example.metadata[:params][:since]) }
      it_responds_with 'a JSON document'
      it_responds_with 'a collection of earthquakes'

      it 'includes only those which occurred since time specified' do
        parsed_response.map { |e| e['date_time'] }.min.should be >= time
      end
      it('includes the example') { should include(earthquakes[:two_minutes_ago]) }

    end

    context '?on=__', params: { on: two_days_ago.to_i } do
      it_responds_with 'a JSON document'
      it_responds_with 'a collection of earthquakes'

      it 'includes only those which occurred on day specified' do
        parsed_response.map { |e| e['date_time'].to_date }.uniq.should == [two_days_ago.to_date]
      end
      it('includes the example') { should include(earthquakes[:two_days_ago]) }

    end

    context '?over=__', params: { over: 8.0 } do
      it_responds_with 'a JSON document'
      it_responds_with 'a collection of earthquakes'

      it 'includes only those with magnitude over given number' do
        parsed_response.map { |e| e['magnitude'] }.min.should(be > 8)
      end
      it('includes the example') { should include(earthquakes[:big]) }
    end

    context '?near=__', params: { near: '37.8266,-122.4224' } do
      let(:target) { example.metadata[:params][:near].split(?,).map(&:to_f) }
      it_responds_with 'a JSON document'
      it_responds_with 'a collection of earthquakes'

      it 'includes only those which occurred within a 5-mile radius of lat/lon provided' do
        parsed_response.map { |e|
          e = e.values_at('latitude', 'longitude')
              # for simplicity, just ask postgres to verify the distance for us:
              sql = 'SELECT earth_distance(ll_to_earth(%f,%f), ll_to_earth(%f,%f))' % [*e, *target]
              Earthquake.connection.select_value(sql).to_f
            }.max.should be < 8047 # 5mi =~ 8046.72m
          end

          it('includes the example') { should include(earthquakes[:nearby]) }
        end

        context '?since=__&on=__' do
          context 'with reasonable values', params: { since: 30.minutes.ago.to_i, on: Time.zone.now.beginning_of_day.to_i } do
            let(:time) { Time.zone.at(example.metadata[:params][:since]) }
            let(:date) { Time.zone.at(example.metadata[:params][:on]).to_date }
            it_responds_with 'a JSON document'
            it_responds_with 'a collection of earthquakes'

            it 'includes only those which occurred on day specified' do
              parsed_response.map { |e| e['date_time'].to_date }.uniq.should == [date]
            end

            it 'includes only those which occurred since time specified' do
              parsed_response.map { |e| e['date_time'] }.min.should be >= time
            end
            it('includes the example') { should include(earthquakes[:two_minutes_ago]) }
          end

          context 'with illogical values', params: { since: 1.day.ago.to_i, on: 3.days.ago.to_i } do
            it_responds_with 'a JSON document'
            it_responds_with 'an empty collection'
          end
        end