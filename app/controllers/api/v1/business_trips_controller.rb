class Api::V1::BusinessTripsController < ApplicationController
  def index
    BusinessTripFacade.get_trip(trip_params)
  end

  private

  def trip_params
    params.permit(:origin, :destination, :search_terms)
  end
end