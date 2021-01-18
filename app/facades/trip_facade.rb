class TripFacade
  def self.get_trip(trip_params)
    
    trip_response = LocationService.get_trip(trip_params)
    
    dest_loc = trip_response[:route][:legs].last[:maneuvers].last[:startPoint]
    org_loc = trip_response[:route][:legs].last[:maneuvers].first[:startPoint]
    
    
    
    
    
    
    origin_weather = WeatherService.get_weather(org_loc)
    origin_tz = origin_weather[:timezone]
    origin_tz_offset = origin_weather[:timezone_offset]
    
    dest_weather = WeatherService.get_weather(dest_loc)
    dest_tz = dest_weather[:timezone]
    dest_tz_offset = dest_weather[:timezone_offset]
    
    current_time = Time.now
    
    trip_data = { start_city: trip_params[:origin],
                  end_city: trip_params[:destination] }
    trip_data[:travel_time] = trip_response[:route][:realTime]
    trip_data[:depart_time] = local_depart_secs(current_time, origin_tz_offset)
    trip_data[:arrival_time] = local_arrival_secs(current_time, dest_tz_offset, trip_data[:travel_time])
    trip_data[:weather_at_eta] = arrival_weather(dest_weather, trip_data[:arrival_time])
    trip = Trip.new(trip_data)
  end

  def self.arrival_weather(dest_weather, arrival_time)
    
    eta_weather = dest_weather[:hourly].find do |hour|
      arrival_time >= hour[:dt] && arrival_time <= hour[:dt] + 3599
    end
    dest_weather[:hourly].last if eta_weather.nil?
  end

  def self.local_depart_secs(local_time, origin_offset)
    utc_time = local_time.utc.strftime('%s').to_i
    origin_time = utc_time + origin_offset
  end

  def self.local_arrival_secs(local_time, dest_offset, travel_time)
    utc_time = local_time.utc.strftime('%s').to_i
    dest_time_before_departure = utc_time + dest_offset
    arrival_time = dest_time_before_departure + travel_time
  end
end
