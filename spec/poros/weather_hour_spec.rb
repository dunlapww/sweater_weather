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
      expect(@weather_hour.time.to_date).to be_a Date
      expect(@weather_hour.temperature.round(2)).to eq(42.04)
      expect(@weather_hour.wind_direction).to eq("NNE")
      expect(@weather_hour.wind_speed).to be_a Float
    end
  end
  describe 'instance methods' do
    it 'to_direction' do
      num = -1
      expect(@weather_hour.to_direction(num)).to eq('N')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('NNE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('NE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('ENE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('E')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('ESE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('SE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('SSE')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('S')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('SSW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('SW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('WSW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('W')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('WNW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('NW')
      num += 22.5
      expect(@weather_hour.to_direction(num)).to eq('NNW')
      num = 360
      expect(@weather_hour.to_direction(num)).to eq('N')
      num = 0
      expect(@weather_hour.to_direction(num)).to eq('N')
    end
  end
end