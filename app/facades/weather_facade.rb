class WeatherFacade

  def self.get_weather(city_state)
    coords = LocationService.lat_lon(city_state)
    weather_data = WeatherService.get_weather(coords)
    Forecast.new(weather_data)
  end
end