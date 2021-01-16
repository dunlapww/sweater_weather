class LocationService
  
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.response(city_state)
    resp = conn.get('/geocoding/v1/address') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = city_state
    end
    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.lat_lon(city_state)
    response(city_state)[:results].first[:locations].first[:latLng]
  end
end