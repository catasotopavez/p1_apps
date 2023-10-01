# app/controllers/api/v1/trip_destinations_controller.rb
class API::V1::TripDestinationsController < APIController
    def index
      trip = Trip.find(params[:trip_id])
      trip_destinations = trip.trip_destinations.map(&:destination)
  
      render json: trip_destinations
    end
  end
  