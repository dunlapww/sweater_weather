class BizTripSerializer
  def self.new(biztrip)
    trip_data = {}
    trip_data[:data] =
      {
        id: nil,
        type: 'munchie',
        attributes:
        {
          destination_city: biztrip.start_city,
          travel_time: biztrip.travel_time,
          forecast:{summary: biztrip.forecast.conditions, temperature: biztrip.forecast.temperature},
          restaurant:{name: biztrip.restaurant.name,address: biztrip.restaurant.address.join(', ')}
        }
      }

    trip_data
  end
end
