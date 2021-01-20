class Api::V1::RoadTripController < ApplicationController
  def create
    trip_params = JSON.parse(request.body.read, symbolize_names: true)
    if trip_params[:api_key].nil? || User.find_by(api_key: trip_params[:api_key]).nil?
      return render json: { errors: [{ detail: 'Invalid API key' }] }, status: :unauthorized
    end

    trip = TripFacade.get_trip(trip_params)
    if trip.instance_of?(Trip)
      render json: TripSerializer.new(trip)
    else
      render json: trip, status: :bad_request
    end
  end
end
