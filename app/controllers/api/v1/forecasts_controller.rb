class Api::V1::ForecastsController < ApplicationController
  def index
    weather = WeatherFacade.get_weather(params[:location])

    if weather.is_a? Forecast
      render json: ForecastSerializer.new(weather).to_json
    else
      render json: weather.to_json
    end
  end
end
