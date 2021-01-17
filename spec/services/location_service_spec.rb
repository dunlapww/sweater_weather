require 'rails_helper'

describe LocationService, type: :service do
  it 'can return lat and long for a city_state' do
    VCR.use_cassette('location_data') do
      results = LocationService.lat_lon("Santa Fe, NM")
      expect(results).to be_a Hash
      expect(results).to have_key(:lat)
      expect(results).to have_key(:lng)
      expect(results[:lat]).to be_a Float
      expect(results[:lng]).to be_a Float
    end
  end
  it 'can get location data' do
    VCR.use_cassette('location_data') do
      results = LocationService.get_location("Santa Fe, NM")
      expect(results).to be_a Hash
      expect(results).to have_key(:results)
      expect(results[:results].first).to have_key(:locations)
      expect(results[:results].first[:locations]).to be_a Array
      expect(results[:results].first[:locations].first).to be_a Hash
      expect(results[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(results[:results].first[:locations].first[:latLng][:lat]).to be_a Float
      expect(results[:results].first[:locations].first[:latLng]).to have_key(:lng)
      expect(results[:results].first[:locations].first[:latLng][:lng]).to be_a Float
    end
  end
  it 'if a bad city_state is entered it returns a failed response' do
    VCR.use_cassette('bad_city_state') do
      results = LocationService.lat_lon("")
      expect(results).to eq({:errors=>[{detail: "Invalid city, state"}]})
    end
    VCR.use_cassette('even_worse_city_state') do
      results = LocationService.lat_lon("/")
      expect(results).to eq({:errors=>[{detail: "Invalid city, state"}]})
    end
  end
end