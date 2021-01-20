class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
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
end
