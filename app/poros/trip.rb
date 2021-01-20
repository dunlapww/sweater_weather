class Trip
  attr_reader :start_city,
              :end_city,
              :loc_arr_time,
              :travel_time,
              :weather_at_eta

  def initialize(trip_data)
    @start_city = trip_data[:start_city]
    @end_city = trip_data[:end_city]
    @loc_arr_time = trip_data[:local_arrival_time]
    @travel_time = to_hours_mins(trip_data[:travel_time])
    @weather_at_eta = WeatherHour.new(trip_data[:weather_at_eta])
  end

  def to_hours_mins(seconds)
    seconds = seconds.abs
    hrs = seconds / 3600
    mins = (seconds % 3600) / 60

    "#{hrs} hour#{pl(hrs)}, #{mins} minute#{pl(mins)}"
  end

  def pl(num)
    num == 1 ? nil : 's'
  end
end
