class WeatherService
  def self.conn
    Faraday.new('https://api.openweathermap.org') do |req|
      req.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end

  def self.get_weather(lat_lon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params[:lat] = lat_lon[:lat]
      req.params[:lon] = lat_lon[:lng]
    end
    body = JSON.parse(response.body, symbolize_names: true)

    if body[:cod]
      {:errors=>[{detail: "#{response[:message]}"}]}
    else
      body
    end

  end

end