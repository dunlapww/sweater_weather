require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful business response when given valid data' do
    VCR.use_cassette('yelp_pueblo_requst') do
      loc_params = {origin: 'Denver, CO', destination: 'Pueblo, CO', search_terms: 'tacos'}
      get '/api/v1/business_trips', params: loc_params
      resp = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(resp).to be_a Hash
      expect(resp).to have_key :data
      expect(resp[:data]).to be_a Hash
      expect(resp[:data]).to have_key :type
      expect(resp[:data][:type]).to eq "munchie"
      expect(resp[:data]).to have_key :attributes
      expect(resp[:data][:attributes]).to be_a Hash
      expect(resp[:data][:attributes]).to have_key :destination_city
      expect(resp[:data][:attributes]).to have_key :travel_time
      expect(resp[:data][:attributes]).to have_key :forecast
      expect(resp[:data][:attributes]).to have_key :restaurant
      expect(resp[:data][:attributes][:forecast]).to have_key :summary
      expect(resp[:data][:attributes][:forecast]).to have_key :temperature
      expect(resp[:data][:attributes][:restaurant]).to have_key :name
      expect(resp[:data][:attributes][:restaurant]).to have_key :address      
    end
  end
end


