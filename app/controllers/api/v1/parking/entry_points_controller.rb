# frozen_string_literal: true

module Api
    module V1::Parking
      class EntryPointsController < ApplicationController
        # GET api/v1/parking/entry_points
        def index
          parking_entry_points = serializer(ParkingEntryPoint.all)
  
          render json: parking_entry_points
        end

        # POST /api/v1/parking/entry_points/
        # Parameters:
        #   - entry_points: [{ name: string}]
        def create
          # TODO add support for multiple ParkingLots
          parking_lot = serializer(ParkingLot.first)[:data][0]
          parking_entry_points = []

          ActiveRecord::Base.transaction do
            params[:entry_points].each do |entry_point|
              parking_entry_point = ParkingEntryPoint.create({
                name: entry_point[:name],
                parking_lot_id: parking_lot[:id]
              })
              parking_entry_points.append(serializer(parking_entry_point)[:data][0])
            end
          end

          render json: { parking_entry_points: parking_entry_points}
        rescue ActiveRecord::RecordNotUnique => error
            return render json: { error: error }
        end

        private

        def serializer(object)
          object_class = object.is_a?(ActiveRecord::Relation) ? object[0].class : object.class
          object_data = object.is_a?(ActiveRecord::Relation) ? object : [object]
          
          serializer = get_serializer(object_class)
          unless serializer
            puts "No serializer for #{object_class}"
          end

          serializer.new(object_data).serializable_hash
        end

        def get_serializer(object_class)
          if object_class == ParkingEntryPoint
            return ParkingEntryPointSerializer
          elsif object_class == ParkingLot
            return ParkingLotSerializer
          end
        end
      end
    end
  end
  