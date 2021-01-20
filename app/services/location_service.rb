class LocationService
  def self.conn
    Faraday.new('https://www.mapquestapi.com') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end

  def self.get_location(city_state)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params[:location] = city_state
    end

    begin
      JSON.parse(response.body, symbolize_names: true)
    rescue JSON::ParserError
      nil
    end
  end

  def self.lat_lon(city_state)
    location_data = get_location(city_state)

    if location_data.nil? || (location_data[:info][:statuscode] != 0)
      { errors: [{ detail: 'Invalid city, state' }] }
    else
      location_data[:results].first[:locations].first[:latLng]
    end
  end

  def self.get_trip(origin_dest)
    response = conn.get('/directions/v2/route') do |req|
      req.params[:from] = origin_dest[:origin]
      req.params[:to] = origin_dest[:destination]
    end
    resp = JSON.parse(response.body, symbolize_names: true)
    resp[:info][:statuscode].zero? ? resp : bad_response(origin_dest)
  end

  def self.bad_response(origin_dest)
    { data:
      { id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: origin_dest[:origin],
          end_city: origin_dest[:destination],
          travel_time: 'impossible',
          weather_at_eta: {}
        } } }
  end
end
