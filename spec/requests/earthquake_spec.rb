require 'spec_helper'

describe "Earthquakes" do 

  let(:earthquake) { FactoryGirl.create(:earthquake) }
  
  describe "get /earthquakes.json" do

    context 'with no params' do

      # expect(response).to be_success
      # expect(json['content']).to 
      # expect(json['private_attr']).to eq(nil)

    end
  end

  context 'with params ?since=__' do
    pending

    it 'includes only quakes since time passed' do
      pending
    end
  end

  context 'with params ?on=__'  do

    it 'includes only quakes on day passed' do
      pending
    end
  end

  context 'params ?over=__' do
    pending
  end

  context 'params ?near=__' do
    pending
    
    it 'returns only quakes within a 5-mile radius of latlong provided' do
      pending
    end

    context 'with params ?since=__&on=__' do
      pending

      it 'returns only quakes on day passed' do
        pending
      end

      it 'returns only quakes since time specified' do
        pending
      end
    end

    context 'with bad parameters' do
      pending
    end
  end
end