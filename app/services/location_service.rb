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

    if location_data.nil? or location_data[:info][:statuscode] != 0
      {:errors=>[{detail: "Invalid city, state"}]}
    else
      location_data[:results].first[:locations].first[:latLng]
    end
  end

  def self.get_trip(origin_dest)
    response = conn.get('/directions/v2/route') do |req|
      req.params[:from] = origin_dest[:origin]
      req.params[:to] = origin_dest[:destination]
    end

    begin
      JSON.parse(response.body, symbolize_names: true)
    rescue JSON::ParserError
      nil
    end
  end

end
