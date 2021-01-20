require 'rails_helper'

describe WeatherHour, type: :model do
  before :each do

    weather_data = File.read('spec/fixtures/poro_data/weather_data.json')
    weather_hash = JSON.parse(weather_data, symbolize_names: true)
    @forecast = Forecast.new(weather_hash)
    @weather_day = @forecast.daily_weather.first
    @weather_hour = @forecast.hourly_weather.first
  end
  it 'has attributes' do
    expect(@weather_day.conditions).to eq("light rain")
    expect(@weather_day.date.to_date).to be_a Date
    expect(@weather_day.icon).to be_a String
    expect(@weather_day.max_temp.round(2)).to eq(43.2)
    expect(@weather_day.min_temp.round(2)).to eq(37.5)
    expect(@weather_day.sunset).to be_a String
    expect(@weather_day.sunrise).to be_a String
  end
end