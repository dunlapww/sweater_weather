class TripSerializer
  def self.new(trip)
    trip_data = {}
    trip_data[:data] =
      { id: nil,
        type: 'roadtrip',
        attributes: { start_city: trip.start_city,
                      end_city: trip.end_city,
                      travel_time: trip.travel_time,
                      weather_at_eta: { temperature: trip.weather_at_eta.temperature,
                                        conditions: trip.weather_at_eta.conditions } } }
    trip_data
  end
end
