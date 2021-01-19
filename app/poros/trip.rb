class Trip
  include WeatherSupport
  attr_reader :start_city,
              :end_city,
              :loc_arr_time,
              :travel_time,
              :weather_at_eta

  def initialize(trip_data)
    @start_city = trip_data[:start_city]
    @end_city = trip_data[:end_city]
    @loc_arr_time = Time.at(trip_data[:arrival_time])
    @travel_time = to_hours_mins(trip_data[:travel_time])
    @weather_at_eta = WeatherHour.new(trip_data[:weather_at_eta])
  end

end
