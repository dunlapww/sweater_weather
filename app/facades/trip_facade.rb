class TripFacade
  def self.get_trip(trip_params)
    trip_response = LocationService.get_trip(trip_params)
    return trip_response if trip_response[:route].nil?

    travel_time = travel_secs(trip_response[:route][:legs][0][:maneuvers])
    arrival_time = Time.now + travel_time

    dest_coords = trip_response[:route][:legs][0][:maneuvers].last[:startPoint]
    dest_weather = WeatherService.get_weather(dest_coords)

    trip_data = {
      start_city: trip_params[:origin],
      end_city: trip_params[:destination],
      travel_time: travel_time,
      local_arrival_time: local_arrival_time(travel_time, dest_weather[:timezone_offset]),
      weather_at_eta: arrival_weather(dest_weather, arrival_time)
    }
    Trip.new(trip_data)
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

  def self.local_arrival_time(travel_time, destination_utc_offset)
    local_time = Time.now.utc + travel_time + destination_utc_offset
    local_time.strftime('%m/%d/%Y %I:%M %p (local time)')
  end
end
