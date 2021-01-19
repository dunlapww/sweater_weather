class TripFacade
  def self.get_trip(trip_params)
    trip_response = LocationService.get_trip(trip_params)
    return trip_response if trip_response[:route].nil?

    travel_time = travel_secs(trip_response[:route][:legs][0][:maneuvers])
    

    dest_loc = trip_response[:route][:legs][0][:maneuvers].last[:startPoint]
    dest_weather = WeatherService.get_weather(dest_loc)
    dest_tz_offset = dest_weather[:timezone_offset]
    utc_arrival_time = Time.now + travel_time

    trip_data = {
      start_city: trip_params[:origin],
      end_city: trip_params[:destination],
      travel_time: travel_time,
      arrival_time: local_arrival_time(travel_time, dest_tz_offset)
    }

    trip_data[:weather_at_eta] = arrival_weather(dest_weather, utc_arrival_time)
    trip = Trip.new(trip_data)

    ######
    arrival_time = (Time.now + travel_time).strftime('%s')
    utc_arrival_time = (Time.now.utc + travel_time).strftime('%s')
    counter = 0
    weather_times = dest_weather[:hourly].map do |hour|
      counter +=1
      "#{counter}: #{hour[:dt]}"
    end
    weather_hour = trip.weather_at_eta.time.strftime('%s')
    ####
    require 'pry'; binding.pry
  end

  def self.travel_secs(trip_legs)
    trip_legs.reduce(0) do |sum, maneuver|
      sum += maneuver[:time]
    end
  end
  
  def self.arrival_weather(dest_weather, utc_arrival_time)
    counter = 0
    eta_weather = dest_weather[:hourly].find do |hour|
      counter += 1
      utc_arrival_time >= hour[:dt] && arrival_time <= hour[:dt] + 3599
    end
    require 'pry'; binding.pry
    if eta_weather
      eta_weather
    else
      eta_weather = dest_weather[:hourly].last
    end
    eta_weather || dest_weather[:hourly].last
  end

  def self.local_arrival_time(travel_time, destination_utc_offset)
    local_time = Time.now.utc + travel_time + destination_utc_offset
    local_time.strftime("%Y-%m-%d %H:%M %p (local time)")
  end
end
