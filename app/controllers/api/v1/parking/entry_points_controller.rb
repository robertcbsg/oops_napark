# frozen_string_literal: true

module Api
  module V1
    module Parking
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
          # TODO: add support for multiple ParkingLots
          parking_lot = ParkingLot.first

          parking_entry_points = []
          ActiveRecord::Base.transaction do
            params[:entry_points].each do |entry_point|
              parking_entry_point = ParkingEntryPoint.create(
                  name: entry_point[:name],
                  parking_lot_id: parking_lot.id
              )
              parking_entry_points.append(serializer(parking_entry_point)[:data][0])
            end
          end

          render json: { parking_entry_points: }
        rescue ActiveRecord::RecordNotUnique => e
          render json: { error: e }
        end
      end
    end
  end
end
