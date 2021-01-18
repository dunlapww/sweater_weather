class Api::V1::RoadtripsController < ApplicationController
  def create
    trip_params = JSON.parse(request.body.read, symbolize_names: true)
    
    trip = TripFacade.get_trip(trip_params)
    render json: TripSerializer.new(trip)
  end
end