class BizTrip
  include WeatherSupport
  attr_reader :start_city,
              :destination_city,
              :loc_arr_time,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(trip_data)
    @start_city = trip_data[:start_city]
    @destination_city = trip_data[:end_city]
    @loc_arr_time = Time.at(trip_data[:arrival_time])
    @travel_time = to_hours_mins(trip_data[:travel_time])
    @forecast = WeatherHour.new(trip_data[:weather_at_eta])
    @restaurant = Business.new(trip_data[:arrival_business])
  end
end
