class Api::V1::RoadtripsController < ApplicationController
  def create
    trip_params = JSON.parse(request.body.read, symbolize_names: true)
    
    trip = TripFacade.get_trip(trip_params)
    if trip.class == Trip
      render json: TripSerializer.new(trip)
    else
      render json: trip, status: :bad_request
    end
  end
end