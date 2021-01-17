require 'rails_helper'

describe WeatherService, type: :service do
  it 'can return the weather when given a lat and long' do
    VCR.use_cassette('valid_weather_response') do
      params = {lat:47.6032,lng:-122.3303}
      results = WeatherService.get_weather(params)
      current = results[:current]
      expect(current[:dt]).to be_a Integer
      expect(current[:sunrise]).to be_a Integer
      expect(current[:sunset]).to be_a Integer
      expect(current[:feels_like]).to be_a Float
      expect(current[:temp]).to be_a Float
      expect(current[:humidity]).to be_a Integer
      expect(current[:uvi]).to be_a Integer
      expect(current[:visibility]).to be_a Integer
      expect(current[:weather].first[:description]).to eq("broken clouds")
      expect(current[:weather].first[:icon]).to eq("04d")
      
      expect(results[:daily]).to be_a Array
      expect(results[:daily].count).to eq(8)
      day = results[:daily].first
      expect(day[:dt]).to be_a Integer
      expect(day[:sunrise]).to be_a Integer
      expect(day[:sunset]).to be_a Integer
      expect(day[:temp][:max]).to be_a Float
      expect(day[:temp][:min]).to be_a Float
      expect(day[:weather].first[:description]).to eq("overcast clouds")
      expect(day[:weather].first[:icon]).to eq("04d")
      
      
      expect(results[:hourly]).to be_a Array
      expect(results[:hourly].count).to eq(48)
      hour = results[:hourly].first
      expect(hour[:dt]).to be_a Integer
      expect(hour[:temp]).to be_a Float
      expect(hour[:wind_speed]).to be_a Float
      expect(hour[:wind_deg]).to be_a Integer
      expect(hour[:weather].first[:description]).to eq("broken clouds")
      expect(hour[:weather].first[:icon]).to eq("04d")
      
    end
  end
  
  it 'if a bad lat/lon is entered it returns a failed response' do
    VCR.use_cassette('bad_weather_response') do
      params = {lat:"3b",lng:"2j"}
      results = WeatherService.get_weather(params)
      expect(results).to have_key(:errors)
    end
    VCR.use_cassette('more_bad_weather_response') do
      params = {lat:9999999,lng:-9999999}
      results = WeatherService.get_weather(params)
      expect(results).to have_key(:errors)
    end
    
  end
end