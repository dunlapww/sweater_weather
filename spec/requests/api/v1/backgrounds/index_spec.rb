require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('valid_image_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/backgrounds', params: loc_params

      expect(response).to be_successful
      image_data = JSON.parse(response.body, symbolize_names: true)
      expect(image_data[:data]).to have_key(:id)
      expect(image_data[:data][:type]).to eq('image')
      expect(image_data[:data][:attributes]).to have_key(:id)
      expect(image_data[:data][:attributes]).to have_key(:image_path)
      expect(image_data[:data][:attributes][:image_path]).to be_a String
      expect(image_data[:data][:attributes][:tags]).to be_a String
    end
  end
end