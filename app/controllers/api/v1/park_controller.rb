# frozen_string_literal: true

module Api
  module V1
    class ParkController < ApplicationController
      # GET api/v1/park/
      def index
        result = serializer(ParkingEntryPoint.first)
        response = result[:data][0][:attributes]

        render json: response
      end

      # POST api/park/
      # {
      #   vehicle: { plate_number: ", size: ""},
      #   parking_entry_point: { id: "" }
      # }
      #
      def create
        vehicle_params = params[:vehicle]

        vehicle = Vehicle.find_by(plate_number: vehicle_params[:plate_number])
        if !vehicle
          vehicle = Vehicle.create(
            plate_number: vehicle_params[:plate_number],
            size: get_vehicle_int_size(vehicle_params[:size]),
            is_parked: false
          )
        elsif vehicle&.is_parked
          error = "#{vehicle_params[:plate_number]} is currently parked, please double check the plate number."
          return render json: { error: }, status: 422
        end

        vehicle = serializer(vehicle)[:data][0][:attributes]

        parking_entry_point_name = params[:parking_entry_point][:name].parameterize
        parking_entry_point = ParkingEntryPoint.find_by(slug: parking_entry_point_name)

        parking_slots =
          ParkingSlot.joins(:distance_from_entries)
                     .where(is_available: false)
                     .where(size: vehicle[:size])
                     .where(distance_from_entries: { slug: parking_entry_name })

        puts parking_slots.class

        unless parking_slots
          error = 'No possible or available slots at the moment.'
          return render json: { error: }, status: 422
        end

        # parking_slots = serializer(parking_slots)[:data]
        # puts parking_slots

        render json: parking_slots
      end

      private

      def get_vehicle_int_size(size)
        size_chart = { 'S' => 0, 'M' => 1, 'L' => 2 }
        size_chart[size]
      end
    end
  end
end

# class Api::V1::ReservationsController < ApplicationController
#     # ...

#     def create
#       # Wrap the update operations in a transaction
#       ActiveRecord::Base.transaction do
#         # Update the first table
#         user = User.find(params[:user_id])
#         user.update!(reservation_params)

#         # Update the second table
#         reservation = Reservation.new(reservation_params)
#         reservation.save!
#       end

#       # Render a success response
#       render json: { message: 'Reservation created successfully' }, status: :created
#     rescue ActiveRecord::RecordInvalid => exception
#       # Handle validation failures
#       render json: { error: exception.message }, status: :unprocessable_entity
#     end

#     private

#     def reservation_params
#       params.require(:reservation).permit(:date, :time, :guests)
#     end
#   end
