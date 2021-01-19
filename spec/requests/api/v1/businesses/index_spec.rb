require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('yelp_pueblo_requst') do
      loc_params = {location: 'Pueblo, CO', search_terms: 'tacos'}
      get '/api/v1/businesses', params: loc_params

      expect(response).to be_successful
    end
  end
end


