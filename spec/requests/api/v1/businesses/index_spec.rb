require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('yelp_pueblo_requst') do
      loc_params = {origin: 'Denver, CO', destination: 'Pueblo, CO', search_terms: 'tacos'}
      get '/api/v1/business_trips', params: loc_params
      resp = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      require 'pry'; binding.pry
    end
  end
end


