module Api
  module V1
    class ParkController < ApplicationController
      protect_from_forgery with: :null_session

      # GET api/park/
      def index
        result = serializer(ParkingEntryPoint.first, ParkingEntryPointSerializer)

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
        parking_entry_point_id = params[:parking_entry_point][:id].to_i

        vehicle = Vehicle.find_by(plate_number: vehicle_params[:plate_number])

        if !vehicle
          vehicle = Vehicle.create(
            plate_number: vehicle_params[:plate_number],
            size: get_vehicle_int_size(vehicle_params[:size]),
            is_parked: false
          )
        # {
        #     "vehicle": {
        #         "id": 11,
        #         "plate_number": "GKO232",
        #         "is_parked": false,
        #         "size": 0,
        #         "created_at": "2024-02-14T20:19:55.540Z",
        #         "updated_at": "2024-02-14T20:19:55.540Z"
        #     }
        # }
        elsif vehicle && vehicle.is_parked
          error = "#{vehicle_params[:plate_number]} is currently parked, please double check the plate number."
          return render json: { error: }, status: 422
        end

        vehicle = serializer(vehicle)[:data][0][:attributes]
        parking_slots = ParkingSlot.where("is_available = 0 AND size >= #{vehicle[:size]}")

        unless parking_slots
          error = 'No possible or available slots at the moment.'
          return render json: { error: }, status: 422
        end

        parking_slots = serializer(parking_slots)[:data]
        puts parking_slots

        render json: parking_slots
      end

      private

      def serializer(object, serializer = nil)
        unless serializer
          object_class = object.is_a?(ActiveRecord::Relation) ? object[0].class : object.class
          if object_class == Vehicle
            serializer = VehicleSerializer
          elsif object_class ==  ParkingSlot
            serializer = ParkingSlotSerializer
          elsif object_class ==  ParkingSlot
            serializer = ParkingSlotSerializer
          elsif object_class == ParkingEntryPoint
            serializer = ParkingEntryPointSerializer
          elsif object_class == ParkingSlip
            serializer = ParkingSlipSerializer
          else
            puts "No serializer for #{object_class}"
          end
        end

        object_data = object.is_a?(ActiveRecord::Relation) ? object : [object]
        serializer.new(object_data).serializable_hash
      end

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
