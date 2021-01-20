class WeatherDay
  include WeatherSupport
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(day)
    @date = to_date(day[:dt])
    @sunrise = to_datetime(day[:sunrise])
    @sunset = to_datetime(day[:sunset])
    @max_temp = to_f(day[:temp][:max])
    @min_temp = to_f(day[:temp][:min])
    @conditions = day[:weather].first[:description]
    @icon = to_icon_path(day[:weather].first[:icon])
  end
end
