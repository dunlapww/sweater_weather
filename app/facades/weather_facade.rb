class WeatherFacade
  def self.get_weather(city_state)
    coords = LocationService.lat_lon(city_state)
    return coords if coords[:errors]
      
    weather_data = WeatherService.get_weather(coords)
    return weather_data if weather_data[:errors]
    
    Forecast.new(weather_data)
  end
end
