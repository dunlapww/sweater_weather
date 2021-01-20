module WeatherSupport
  def to_date(time_in_seconds)
    time = Time.zone.at(time_in_seconds).to_datetime
    time.strftime('%F')
  end

  def to_datetime(time_in_seconds)
    Time.zone.at(time_in_seconds).strftime('%m/%d/%Y %H:%M:%S %z')
  end

  def to_time(time_in_seconds)
    Time.zone.at(time_in_seconds).strftime('%H:%M:%S %z')
  end

  def to_f(kelvin)
    ((kelvin - 273.15) * (9 / 5) + 32).round(1)
  end

  def to_icon_path(icon)
    "http://openweathermap.org/img/wn/#{icon}@2x.png"
  end

  def to_direction(wind_angle)
    val = wind_angle / 22.5 + 0.5
    arr = %w[N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW]
    "from #{arr[(val % 16)]}"
  end

  def to_mph(meters_per_sec)
    (meters_per_sec * 2.23694).round(0)
  end
end
