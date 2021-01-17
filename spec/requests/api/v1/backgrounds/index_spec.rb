RSpec.describe 'Search' do
  it 'returns successful weather response when given valid data' do
    VCR.use_cassette('valid_image_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/backgrounds', params: loc_params

      expect(response).to be_successful
      loc_data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end