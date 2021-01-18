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
      require 'pry'; binding.pry
      expect(trip_data).to have_key(:data)
    end
  end
end
