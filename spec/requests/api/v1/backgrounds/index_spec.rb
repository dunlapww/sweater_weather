require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('valid_image_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/backgrounds', params: loc_params

      expect(response).to be_successful
      image_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(image_data).to be_a Hash
      expect(image_data).to have_key :data
      expect(image_data[:data]).to have_key :id
      expect(image_data[:data]).to have_key :type
      expect(image_data[:data]).to have_key :attributes
      expect(image_data[:data][:attributes]).to have_key :id
      expect(image_data[:data][:attributes]).to have_key :curator
      expect(image_data[:data][:attributes]).to have_key :artist_link
      expect(image_data[:data][:attributes]).to have_key :artist_name
      expect(image_data[:data][:attributes]).to have_key :image_path
      expect(image_data[:data][:attributes]).to have_key :alt_description
      
    end
  end
end