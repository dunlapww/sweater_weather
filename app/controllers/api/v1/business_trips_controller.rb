class Api::V1::BusinessTripsController < ApplicationController
  def index
    biz_trip = BusinessTripFacade.get_trip(trip_params)
    test = BizTripSerializer.new(biz_trip)
    require 'pry'; binding.pry
  end

  private

  def trip_params
    params.permit(:origin, :destination, :search_terms)
  end
end