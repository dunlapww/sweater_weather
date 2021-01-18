require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful road_trip response when given valid data' do
    VCR.use_cassette('road_trip_valid_request') do
      trip_params = { origin: 'Seattle, WA', destination: 'Denver, CO' }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/roadtrip', params: trip_params.to_json, headers: headers

      expect(response).to be_successful
      trip_data = JSON.parse(response.body, symbolize_names: true)
      expect(trip_data).to have_key(:data)
    end
  end
end
