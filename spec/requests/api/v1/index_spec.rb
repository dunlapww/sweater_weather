require 'rails_helper'

RSpec.describe 'Search' do
  it 'returns successful mapquest response' do
    VCR.use_cassette('mapquest_request') do
      loc_params = {location: 'Seattle, WA'}
      get '/api/v1/forecast', params: loc_params

      expect(response).to be_successful
      loc_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(loc_data).to have_key(:data)
      
      expect(loc_data[:data]).to have_key(:id)
      expect(loc_data[:data][:id]).to eq(nil)
      expect(loc_data[:data]).to have_key(:type)
      expect(loc_data[:data][:type]).to eq("forecast")
      expect(loc_data[:data][:attributes]).to be_a Hash
      
      
      expect(loc_data[:data][:attributes]).to have_key(:datetime)
      expect(loc_data[:data][:attributes][:datetime]).to eq("2021-01-15")
      
      expect(loc_data[:data][:attributes]).to have_key(:sunrise)
      expect(loc_data[:data][:attributes][:sunrise]).to eq("2021-01-15T08:52:27.000-07:00")
      
      expect(loc_data[:data][:attributes]).to have_key(:sunset)
      expect(loc_data[:data][:attributes][:sunset]).to eq("2021-01-15T17:44:54.000-07:00")
      
      expect(loc_data[:data][:attributes]).to have_key(:temperature)
      expect(loc_data[:data][:attributes][:temperature].round(2)).to eq(42.04)
      
      expect(loc_data[:data][:attributes]).to have_key(:feels_like)
      expect(loc_data[:data][:attributes][:feels_like].round(2)).to eq(40.19)
      
      expect(loc_data[:data][:attributes]).to have_key(:icon)
      expect(loc_data[:data][:attributes][:icon]).to eq("http://openweathermap.org/img/wn/03d@2x.png")
      
      expect(loc_data[:data][:attributes]).to have_key(:daily_weather)
      expect(loc_data[:data][:attributes][:daily_weather]).to be_a Array
      expect(loc_data[:data][:attributes][:daily_weather].size).to eq(5)
      loc_data[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a Hash
        expect(day[:date].to_date).to be_a Date
        expect(day[:sunrise].to_date).to be_a Date
        expect(day[:sunset].to_date).to be_a Date
        expect(day[:max_temp]).to be_a Float
        expect(day[:min_temp]).to be_a Float
        expect(day[:conditions]).to be_a String
        expect(day[:icon]).to be_a String
      end
      
      expect(loc_data[:data][:attributes]).to have_key(:hourly_weather)
      expect(loc_data[:data][:attributes][:hourly_weather]).to be_a Array
      expect(loc_data[:data][:attributes][:hourly_weather].size).to eq(8)
      loc_data[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to be_a Hash
        expect(hour[:time].to_date).to be_a Date
        expect(hour[:wind_speed]).to be_a Float
        expect(hour[:wind_direction]).to be_a String
        expect(hour[:conditions]).to be_a String
        expect(hour[:icon]).to be_a String
      end
      

    end
  end
end


