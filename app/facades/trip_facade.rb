class TripFacade
  def self.get_trip(trip_params)
    trip_response = LocationService.get_trip(trip_params)
    return trip_response if trip_response[:route].nil?
    
    travel_time = trip_response[:route][:realTime]

    dest_loc = trip_response[:route][:legs].last[:maneuvers].last[:startPoint]
    dest_weather = WeatherService.get_weather(dest_loc)
    dest_tz_offset = dest_weather[:timezone_offset]

    trip_data = {
      start_city: trip_params[:origin],
      end_city: trip_params[:destination],
      travel_time: travel_time,
      arrival_time: local_arrival_secs(dest_tz_offset, travel_time)
    }

    trip_data[:weather_at_eta] = arrival_weather(dest_weather, trip_data[:arrival_time])
    Trip.new(trip_data)
  end

  def self.arrival_weather(dest_weather, arrival_time)
    eta_weather = dest_weather[:hourly].find do |hour|
      arrival_time >= hour[:dt] && arrival_time <= hour[:dt] + 3599
    end

    eta_weather || dest_weather[:hourly].last
  end

  def self.local_arrival_secs(dest_offset, travel_time)
    utc_time = Time.now.utc.strftime('%s').to_i
    utc_time + dest_offset + travel_time
  end
end
