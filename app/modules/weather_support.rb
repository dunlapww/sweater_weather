module WeatherSupport

  private

  def to_date(time_in_seconds)
    time = Time.at(time_in_seconds).to_datetime
    time.strftime("%F")
  end

  def to_time(time_in_seconds)
    Time.at(time_in_seconds).to_datetime
  end

  def to_f(kelvin)
    (kelvin - 273.15) * (9 / 5) + 32
  end

  def to_icon_path(icon)
    "http://openweathermap.org/img/wn/#{icon}@2x.png"
  end

  def to_direction(wind_angle)
    case wind_angle
    when (348.75..360) || (0..11.25)
      "N"
    when 11.25..33.75
      "NNE"
    when 33.75..56.25
      "NE"
    when 56.25..78.75
      "ENE"
    when 78.75..101.25
      "E"
    when 101.25..123.75
      "ESE"
    when 123.75..146.25
      "SE"
    when 146.25..168.75
      "SSE"
    when 168.75..191.25
      "S"
    when 191.25..213.75
      "SSW"
    when 213.75..236.25 
      "SW"
    when 236.25..258.75
      "WSW"
    when 258.75..281.25
      "W"
    when 281.25..303.75
      "WNW"
    when 303.75..326.25
      "NW"
    when 326.25..348.75
      "NNW"
    else
      "Unknown"
    end
  end

end