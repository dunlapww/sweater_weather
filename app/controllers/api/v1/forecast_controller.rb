class Api::V1::ForecastController < ApplicationController
  def index
    weather = WeatherFacade.get_weather(params[:location])
    render json: ForecastSerializer.new(weather).to_json
  end
end
