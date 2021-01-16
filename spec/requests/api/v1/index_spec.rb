require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful mapquest response' do
    VCR.use_cassette('mapquest_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/forecast', params: loc_params

      expect(response).to be_successful
      loc_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(loc_data).to have_key(:results)
      expect(loc_data[:results]).to have_key(:results)

      require 'pry'; binding.pry

    end
  end
end


