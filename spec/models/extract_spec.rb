require 'spec_helper'

describe Extract do

  describe "Extract#run" do

    before do
      WebMock.stub_request(:get, 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv')
        .to_return(body: <<-CSV)
time,latitude,longitude,depth,mag,magType,nst,gap,dmin,rms,net,id,updated,place,type
2014-01-31T23:48:35.541Z,37.0648,-115.086,8,1.16,ml,7,181.16,0.343,,nn,nn00436847,2014-01-31T23:50:35.000Z,"34km SSE of Alamo, Nevada",earthquake
2014-01-31T23:31:14.741Z,40.6435,-118.7452,4,1.93,ml,12,277.31,0.803,,nn,nn00436846,2014-01-31T23:33:58.000Z,"54km E of Gerlach-Empire, Nevada",earthquake')
CSV
    end

    it 'changes then number of Earthquake objects in the db' do
      Extract.run
      expect(Earthquake.count).to be == 2
    end

    describe 'the earthquakes attributes' do
      subject { Earthquake.first }

      before do
        Extract.run
      end

      its(:quake_date) { should eq '2014-01-31T23:48:35.541Z' }
    end
  end
  
end