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
      #   vehicle: { plate_number: "", size: ""},
      #   parking_entry_point: { name: "" }
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

        parking_entry_point_name = params[:parking_entry_point][:name].parameterize
        
        parking_entry_point = ParkingEntryPoint.find_by(slug: parking_entry_point_name)
        unless parking_entry_point
          error = 'Parking entry point does not exist, please double check the name.'
          return render json: { error: }, status: 422
        end

        parking_entry_point_id = serializer(parking_entry_point)[:data][0][:id]
        vehicle = serializer(vehicle)[:data][0][:attributes]
        
        parking_slots =
          ParkingSlot.joins(:distance_from_entries)
                     .where(is_available: true)
                     .where("size >= ?", vehicle[:size])
                     .where(distance_from_entries: { parking_entry_point_id: })
                     .order('distance_from_entries.distance')

        unless parking_slots.length != 0
          error = 'No possible or available slots at the moment.'
          return render json: { error: }, status: 422
        end

        nearest_parking_slot = ParkingSlotSerializer.new(
          parking_slots, include: [:distance_from_entries]
        ).serializable_hash[:data][0]

        distance_array = get_distance_array(nearest_parking_slot[:id])
        parking_slip = park_vehicle(vehicle[:id], nearest_parking_slot[:id])

        render json: {
          parking_slot_id: nearest_parking_slot[:id],
          parking_slip_id: parking_slip[:id],
          distance_array:,
        }
      end

      private

      def get_vehicle_int_size(size)
        size_chart = { 'S' => 0, 'M' => 1, 'L' => 2 }
        size_chart[size]
      end

      def get_distance_array(parking_slot_id)
        distance_from_entries = serializer(
          DistanceFromEntry.where(parking_slot_id:)
                           .order(:parking_entry_point_id)
        )[:data]

        distance_array = []
        distance_from_entries.each do |distance_from_entry|
          distance_array.append(distance_from_entry[:attributes][:distance])
        end
        return distance_array
      end

      # updates vehicle and parking slot 'is_parked' state
      # returns parking slip
      def park_vehicle(vehicle_id, parking_slot_id)
        ActiveRecord::Base.transaction do
          Vehicle.find_by(id: vehicle_id).update(is_parked: true)
          ParkingSlot.find_by(id: parking_slot_id).update(is_available: false)

          datetime_now = serializer(Clock.first)[:data][0][:attributes][:datetime_now]
          parking_slip = ParkingSlip.create(
            time_in: datetime_now,
            effective_time_in: datetime_now,
            vehicle_id:,
            parking_slot_id:,
          )
          serializer(parking_slip)[:data][0][:attributes]
        end
      end
    end
  end
end
