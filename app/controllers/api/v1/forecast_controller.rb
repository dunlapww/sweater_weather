class Api::V1::ForecastController < ApplicationController
  def index
    def loc_conn
      Faraday.new('https://www.mapquestapi.com')
    end

    response = loc_conn.get('/geocoding/v1/address') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = params[:location]
    end
    location_data = JSON.parse(response.body, symbolize_names: true)
    lat_long = location_data[:results].first[:locations].first[:latLng]
    
    def weather_conn
      Faraday.new('https://api.openweathermap.org') do |req|
        req.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
      end
    end

    weather_response = weather_conn.get('/data/2.5/onecall') do |req|
      req.params[:lat] = lat_long[:lat]
      req.params[:lon] = lat_long[:lng]
    end

    weather_data = JSON.parse(weather_response.body, symbolize_names: true)
    
    weather = CurrentWeather.new(weather_data)
    require 'pry'; binding.pry

    render json: payload
  end
end
