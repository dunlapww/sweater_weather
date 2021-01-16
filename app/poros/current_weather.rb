class CurrentWeather
  attr_reader :id,
              :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon,
              :daily_weather,
              :hourly_weather

  def initialize(weather_data)
    @id = nil
    @datetime = weather_data[:current][:dt]
    @sunrise = weather_data[:current][:sunrise]
    @sunset = weather_data[:current][:sunset]
    @temperature = weather_data[:current][:temp]
    @feels_like = weather_data[:current][:feels_like]
    @humidity = weather_data[:current][:humidity]
    @uvi = weather_data[:current][:uvi]
    @visibility = weather_data[:current][:visibility]
    @conditions = weather_data[:current][:weather].first[:description]
    @icon = weather_data[:current][:weather].first[:icon]
    @daily_weather = daily(weather_data[:daily], 5)
    @hourly_weather = hourly(weather_data[:hourly], 8)
  end

  def daily(weather_days, days)
    weather_days.first(days).map do |day|
      WeatherDay.new(day)
    end
  end

  def hourly(weather_hours, hours)
    weather_hours.first(hours).map do |hour|
      WeatherHour.new(hour)
    end
  end
end
