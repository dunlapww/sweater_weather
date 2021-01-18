require 'rails_helper'

describe TripFacade, type: :facade do
  before :each do
    @user = User.create({ email: 'new_user@email.com', password: 'abc123', password_confirmation: 'abc123' })
    @user = User.find(@user.id)

    json = File.read('spec/fixtures/poro_data/weather_data.json')
    @all_weather = JSON.parse(json, symbolize_names: true)
  end
  describe 'class methods' do
    it 'get_trip - valid' do
      VCR.use_cassette('valid_trip_facade') do
        trip_params = { origin: 'Seattle, WA',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        trip = TripFacade.get_trip(trip_params)
        expect(trip).to be_a Trip
      end
    end
    it 'get_trip - no origin' do
      VCR.use_cassette('no_origin_trip_facade') do
        trip_params = { origin: '',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        trip = TripFacade.get_trip(trip_params)
        expect(trip).to be_a Hash
        expected = {:errors=>[{:detail=>"At least two locations must be provided."}]}
        expect(trip).to eq(expected)
      end
    end
    it 'get_trip - bad origin' do
      VCR.use_cassette('bad_origin_trip_facade') do
        trip_params = { origin: '/',
          destination: 'Denver, CO',
          api_key: @user.api_key }
        trip = TripFacade.get_trip(trip_params)
        expect(trip).to be_a Hash
        expected = {:errors=>[{:detail=>"Error processing request: Encountered an error while trying to batch geocode: Geocode Failed: A JSONObject text must begin with '{' at character 0 of "}]}
        expect(trip).to eq(expected)
      end
    end
    it 'arrival_weather' do
      VCR.use_cassette('arrival_weather_in_range') do
        time_in_secs = 1610758830
        weather = TripFacade.arrival_weather(@all_weather, time_in_secs)
        expect(weather).to be_a Hash
        expect(time_in_secs).to be > (weather[:dt])
        expect(time_in_secs).to be < (weather[:dt]+3600)
      end
      VCR.use_cassette('arrival_weather_out_of_range') do
        time_in_secs = 9
        weather = TripFacade.arrival_weather(@all_weather, time_in_secs)
        expect(weather).to eq(@all_weather[:hourly].last)
      end
    end
    it 'local_arrival_time' do
      dest_offset = 10
      travel_time = 15
      current_utc_time = Time.now.utc.strftime('%s').to_i
      time = TripFacade.local_arrival_secs(dest_offset, travel_time)
      expect(time).to eq(current_utc_time + dest_offset + travel_time)
    end
  end
end