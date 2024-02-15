# frozen_string_literal: true

module Api
  module V1
    module Parking
      class SlotsController < ApplicationController
        def index
          parking_slots = serializer(ParkingSlot.all)

          render json: parking_slots
        end

        def create
          # TODO: add support for multiple ParkingLots
          parking_lot = serializer(ParkingLot.first)[:data][0]
          
          ActiveRecord::Base.transaction do
            size = get_parking_lot_int_size(params[:size])
            parking_slot = ParkingSlot.create(
              size:,
              is_available: true,
              parking_lot_id: parking_lot[:id],
            )
            parking_slot_id = serializer(parking_slot)[:data][0][:id]

            distance_from_entries =  []
            params[:distance_from_entries].each do |distance_from_entry|
              slug = distance_from_entry[:name].parameterize
              parking_entry_point = ParkingEntryPoint.find_by(slug:)

              unless parking_entry_point
                raise ActiveRecord::Rollback
              end

              parking_entry_point_id = serializer(parking_entry_point)[:data][0][:id]

              result = DistanceFromEntry.create(
                distance: distance_from_entry[:distance].to_i,
                parking_entry_point_id:,
                parking_slot_id:,
              )
              distance_from_entries.append(serializer(result)[:data][0])
            end
          rescue ActiveRecord::Rollback => e
            return render json: { error: "Parking Entry not found, please double check the name." }, status: 500
          end
          render json: { message: "success" }
        end

        private

        def get_parking_lot_int_size(size)
          size_chart = { 'SP' => 0, 'MP' => 1, 'LP' => 2 }
          size_chart[size]
        end
      end
    end
  end
end
