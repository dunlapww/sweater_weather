require 'rails_helper'

describe WeatherDay, type: :model do
  before :each do

    weather_data = File.read('spec/fixtures/poro_data/weather_data.json')
    weather_hash = JSON.parse(weather_data, symbolize_names: true)
    @forecast = Forecast.new(weather_hash)
    @weather_day = @forecast.daily_weather.first
    @weather_hour = @forecast.hourly_weather.first
  end
  it 'has attributes' do
    expect(@weather_hour.conditions).to eq("scattered clouds")
    expect(@weather_hour.icon).to be_a String
    expect(@weather_hour.time.to_date).to be_a Date
    expect(@weather_hour.temperature.round(2)).to eq(42.04)
    expect(@weather_hour.wind_direction).to eq("NNE")
    expect(@weather_hour.wind_speed).to be_a Float
  end
end