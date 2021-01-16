class WeatherDay
      
  def initialize(day)
    @date = day[:dt]
    @sunrise = day[:sunrise]
    @sunset = day[:sunset]
    @max_temp = day[:temp][:max]
    @min_temp = day[:temp][:min]
    @conditions = day[:weather].first[:description]
    @icon = day[:weather].first[:description]
  end
end