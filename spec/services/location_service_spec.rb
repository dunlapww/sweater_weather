require 'rails_helper'

describe LocationService, type: :service do
  describe 'class methods' do
    before :each do
      @user = User.create({ email: 'new_user@email.com', password: 'abc123', password_confirmation: 'abc123' })
      @user = User.find(@user.id)
    end
    it 'get_location' do
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
    it 'lat_lon valid' do
      VCR.use_cassette('location_data') do
        results = LocationService.lat_lon("Santa Fe, NM")
        expect(results).to be_a Hash
        expect(results).to have_key(:lat)
        expect(results).to have_key(:lng)
        expect(results[:lat]).to be_a Float
        expect(results[:lng]).to be_a Float
      end
    end
    it 'lat_lon invalid_data' do
      VCR.use_cassette('bad_city_state') do
        results = LocationService.lat_lon("")
        expect(results).to eq({:errors=>[{detail: "Invalid city, state"}]})
      end
      VCR.use_cassette('even_worse_city_state') do
        results = LocationService.lat_lon("/")
        expect(results).to eq({:errors=>[{detail: "Invalid city, state"}]})
      end
    end
    it 'get_trip - valid' do
      VCR.use_cassette('valid_trip') do
        trip_params = { origin: 'Seattle, WA',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        results = LocationService.get_trip(trip_params)
        expect(results).to be_a Hash

        expect(results[:route][:legs].last[:maneuvers].first[:startPoint]).to be_a Hash
        expect(results[:route][:legs].last[:maneuvers].first[:startPoint]).to have_key(:lat)
        expect(results[:route][:legs].last[:maneuvers].first[:startPoint]).to have_key(:lng)
        expect(results[:route][:legs].last[:maneuvers].last[:startPoint]).to be_a Hash
        expect(results[:route][:legs].last[:maneuvers].last[:startPoint]).to have_key(:lat)
        expect(results[:route][:legs].last[:maneuvers].last[:startPoint]).to have_key(:lng)
        expect(results[:route][:realTime]).to be_a Integer
      end
    end
    it 'get_trip - missing' do
      VCR.use_cassette('missing_origin_trip') do
        trip_params = { origin: '',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        results = LocationService.get_trip(trip_params)

      end
    end
    it 'get_trip - invalid' do
      VCR.use_cassette('invalid_trip') do
        trip_params = { origin: '/',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        results = LocationService.get_trip(trip_params)

      end
    end
  end
end