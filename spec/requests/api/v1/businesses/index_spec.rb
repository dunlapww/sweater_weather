require 'rails_helper'

describe 'when I receive a request to create a new user' do
  it "I'm able to consume the json body" do
    #VCR.use_cassette('pueblo_yelp_search') do
      #headers = { "CONTENT_TYPE" => "application/json"}
      biz_params = {location: 'Pueblo, CO', search_term: 'tacos'}
      
      get '/api/v1/businesses', params: biz_params
      
      expect(response).to be_successful
    #end
  end
end