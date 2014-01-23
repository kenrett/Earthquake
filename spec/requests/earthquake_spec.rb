require 'spec_helper'

url = 'http://desolate-escarpment-4897.herokuapp.com'

describe "Earthquakes" do 

  after do
    VCR.eject_cassette
  end

  describe "get /earthquakes.json" do

    context 'with no params' do
      VCR.use_cassette('no_params', :record => :new_episodes) do
        response = Net::HTTP.get_response(URI("#{url}/earthquakes.json")).read_body.split("},{")
        
        it 'should have 775 quakes' do
          response.count.should == 775
        end 
      end
    end
  end

  context 'with params ?since=__' do
    VCR.use_cassette('since', :record => :new_episodes) do
      response = Net::HTTP.get_response(URI("#{url}/earthquakes.json?since=1390348800")).read_body.split("},{")

      it 'should include 13 quakes' do
        response.count.should == 13
      end
    end
  end

  context 'with params ?on=__'  do
    VCR.use_cassette('on', :record => :new_episodes) do
      response = Net::HTTP.get_response(URI("#{url}/earthquakes.json?on=1390348800")).read_body.split("},{")

      it 'includes only 13 quakes' do
        response.count.should == 13
      end
    end
  end

  context 'params ?over=__' do
    VCR.use_cassette('over', :record => :new_episodes) do
      response = Net::HTTP.get_response(URI("#{url}/earthquakes.json?over=3.2")).read_body.split("},{")

      it 'should only include 19 quakes' do
        response.count.should == 19
      end
    end
  end

  context 'params ?near=__' do
    VCR.use_cassette('near', :record => :new_episodes) do
      response = Net::HTTP.get_response(URI("#{url}/earthquakes.json?near=36.6702,-114.8870")).read_body.split("},{")

      it 'returns only 1 quake within a 5-mile radius of latlong provided' do
        response.count.should == 1
      end
    end
  end

  context 'with params ?over=__&on=__&since=__' do
    VCR.use_cassette('over_on_since', :record => :new_episodes) do
      response = Net::HTTP.get_response(URI("#{url}/earthquakes.json?over=1.2&on=1390348800&since=1390176000")).read_body.split("},{")

      it 'returns only quakes on day passed' do
        response.count.should == 6
      end

      it 'returns only quakes since time specified' do
        response.count.should == 6
      end
    end
  end

  context 'with bad parameters' do

    it "should fail correctly" do
      pending
    end
  end
end