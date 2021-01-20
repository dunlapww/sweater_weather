require 'rails_helper'

describe WeatherDay, type: :model do
  before :each do
    weather_data = File.read('spec/fixtures/poro_data/weather_data.json')
    weather_hash = JSON.parse(weather_data, symbolize_names: true)
    @forecast = Forecast.new(weather_hash)
    @weather_day = @forecast.daily_weather.first
    @weather_hour = @forecast.hourly_weather.first
  end
  describe 'WeatherDay' do
    it 'has attributes' do
      expect(@weather_hour.conditions).to eq("scattered clouds")
      expect(@weather_hour.icon).to be_a String
      expect(@weather_hour.time).to be_a String
      expect(@weather_hour.temperature.round(2)).to eq(42.0)
      expect(@weather_hour.wind_direction).to eq("from NNE")
      expect(@weather_hour.wind_speed).to be_a String
    end
  end
  describe 'instance methods' do
    it 'to_direction' do
      num = -1
      expect(@weather_hour.to_direction(num)).to eq('from N')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from NNE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from NE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from ENE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from E')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from ESE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from SE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from SSE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from S')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from SSW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from SW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from WSW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from W')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from WNW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from NW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('from NNW')
      num = 360
      expect(@weather_hour.to_direction(num)).to eq('from N')
      num = 0
      expect(@weather_hour.to_direction(num)).to eq('from N')
    end
  end
end