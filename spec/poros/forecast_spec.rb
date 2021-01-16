require 'rails_helper'

describe Forecast, type: :model do
  it 'has attributes' do
    weather_data = File.read('spec/fixtures/poro_data/weather_data.json')
    weather_hash = JSON.parse(weather_data, symbolize_names: true)
    forecast = Forecast.new(weather_hash)
    expect(forecast.conditions).to eq("scattered clouds")
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather.all? {|day| day.class == WeatherDay}).to eq(true)
    expect(forecast.datetime.to_date).to be_a Date
    expect(forecast.icon).to be_a String
    expect(forecast.feels_like.round(2)).to eq(40.19)
    expect(forecast.humidity.round(2)).to eq(71)
    expect(forecast.temperature.round(2)).to eq(42.04)
    expect(forecast.icon).to be_a String
    expect(forecast.id).to eq nil
    expect(forecast.sunset.to_date).to be_a Date
    expect(forecast.sunrise.to_date).to be_a Date
    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather.all? {|hour| hour.class == WeatherHour}).to eq(true)
  end
end