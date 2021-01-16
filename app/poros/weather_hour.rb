class WeatherHour
  def initialize(hour)
    @id = nil
    @time = hour[:dt]
    @temperature = hour[:temp]
    @wind_speed = hour[:wind_speed]
    @wind_direction = hour[:wind_deg]
    @conditions = hour[:weather].first[:description]
    @icon = hour[:weather].first[:icon]
  end
end