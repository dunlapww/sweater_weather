class BusinessTripFacade
  def self.get_trip(trip_params)
    trip_response = LocationService.get_trip(trip_params)
    return trip_response if trip_response[:route].nil?

    travel_time = travel_secs(trip_response[:route][:legs][0][:maneuvers])
    dest_loc = trip_response[:route][:legs][0][:maneuvers].last[:startPoint]

    dest_weather = WeatherService.get_weather(dest_loc)
    dest_tz_offset = dest_weather[:timezone_offset]
    local_arrival_time = local_arrival_secs(dest_tz_offset, travel_time)
    
    dest_business = BusinessService.get_business(trip_params, local_arrival_time)    
    require 'pry'; binding.pry
    trip_data = {
      start_city: trip_params[:origin],
      end_city: trip_params[:destination],
      travel_time: travel_time,
      arrival_time: local_arrival_time,
      arrival_business: dest_business[:businesses].first
    }

    trip_data[:weather_at_eta] = arrival_weather(dest_weather, trip_data[:arrival_time])
    BizTrip.new(trip_data)
  end

  def self.travel_secs(trip_legs)
    trip_legs.reduce(0) do |sum, maneuver|
      sum += maneuver[:time]
    end
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
