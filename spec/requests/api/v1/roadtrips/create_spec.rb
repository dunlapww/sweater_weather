require 'rails_helper'

RSpec.describe 'Search' do
  before :each do
    @user = User.create({ email: 'new_user@email.com', password: 'abc123', password_confirmation: 'abc123' })
    @user = User.find(@user.id)
  end
  it 'returns successful road_trip response when given valid data' do
    VCR.use_cassette('road_trip_valid_request') do
      trip_params = { origin: 'Seattle, WA',
                      destination: 'Denver, CO',
                      api_key: @user.api_key }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/roadtrips', params: trip_params.to_json, headers: headers

      expect(response).to be_successful
      trip_data = JSON.parse(response.body, symbolize_names: true)
      expect(trip_data).to have_key(:data)
      expect(trip_data[:data]).to be_a Hash
      expect(trip_data[:data]).to have_key :id
      expect(trip_data[:data]).to have_key :type
      expect(trip_data[:data][:type]).to eq 'roadtrip'
      expect(trip_data[:data]).to have_key :attributes
      expect(trip_data[:data][:attributes]).to be_a Hash
      expect(trip_data[:data][:attributes]).to have_key :start_city
      expect(trip_data[:data][:attributes][:start_city]).to eq(trip_params[:origin])
      expect(trip_data[:data][:attributes]).to have_key :end_city
      expect(trip_data[:data][:attributes][:end_city]).to eq(trip_params[:destination])
      expect(trip_data[:data][:attributes]).to have_key :travel_time
      expect(trip_data[:data][:attributes][:travel_time]).to be_a String
      expect(trip_data[:data][:attributes]).to have_key :weather_at_eta
      expect(trip_data[:data][:attributes][:weather_at_eta]).to be_a Hash
      expect(trip_data[:data][:attributes][:weather_at_eta]).to have_key :temperature
      expect(trip_data[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(trip_data[:data][:attributes][:weather_at_eta]).to have_key :conditions
      expect(trip_data[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
  end
  it 'returns unsuccessful response when given invalid data' do
    VCR.use_cassette('road_trip_no_origin_request') do
      trip_params = { origin: '',
                      destination: 'Denver, CO',
                      api_key: @user.api_key }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/roadtrips', params: trip_params.to_json, headers: headers

      resp = JSON.parse(response.body, symbolize_names: true)
      expected = {:errors=>[{:detail=>"At least two locations must be provided."}]}
      expect(resp).to eq(expected)
      expect(response.status).to eq(400)
    end
    VCR.use_cassette('road_trip_bad_origin_request') do
      trip_params = { origin: '/',
                      destination: 'Denver, CO',
                      api_key: @user.api_key }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/roadtrips', params: trip_params.to_json, headers: headers

      resp = JSON.parse(response.body, symbolize_names: true)
      expected = {:errors=>[{:detail=>"Error processing request: Encountered an error while trying to batch geocode: Geocode Failed: A JSONObject text must begin with '{' at character 0 of "}]}
      expect(resp).to eq(expected)
      expect(response.status).to eq(400)
    end
  end

end
