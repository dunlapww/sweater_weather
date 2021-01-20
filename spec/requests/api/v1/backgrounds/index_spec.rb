require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('valid_image_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/backgrounds', params: loc_params

      expect(response).to be_successful
      image_data = JSON.parse(response.body, symbolize_names: true)
      expect(image_data).to be_a Hash
      expect(image_data).to have_key :user
      expect(image_data[:user]).to have_key :portfolio_url
      expect(image_data[:user]).to have_key :name
      expect(image_data).to have_key :alt_description
      expect(image_data).to have_key :urls
      expect(image_data[:urls]).to have_key :small
    end
  end
end