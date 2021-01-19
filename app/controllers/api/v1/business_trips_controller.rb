class Api::V1::BusinessTripsController < ApplicationController
  def index
    biz_trip = BusinessTripFacade.get_trip(trip_params)
    render json: BizTripSerializer.new(biz_trip)
  end

  private

  def trip_params
    params.permit(:origin, :destination, :search_terms)
  end
end