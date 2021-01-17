class WeatherHour
  include WeatherSupport
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(hour)
    @time = to_time(hour[:dt])
    @temperature = to_f(hour[:temp])
    @wind_speed = hour[:wind_speed]
    @wind_direction = to_direction(hour[:wind_deg])
    @conditions = hour[:weather].first[:description]
    @icon = to_icon_path(hour[:weather].first[:icon])
  end
end
