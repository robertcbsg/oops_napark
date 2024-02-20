# frozen_string_literal: true
require 'date'

module Api
  module V1
    module Parking
      class SlipsController < ApplicationController
          def show
            parking_slips = ParkingSlip.all.includes(:vehicle, :parking_slot).order('id desc').limit(10)

            parking_slip_details = []
            parking_slips.each do |slip|
              time_in = slip.effective_time_in.strftime("%d %b %Y %I:%M %p") if slip.effective_time_in
              time_out = slip.time_out.strftime("%d %b %Y %I:%M %p") if slip.time_out
              parking_slip_details.append({
                id: slip.id,
                plate_number: slip.vehicle.plate_number,
                parking_slot_size: get_parking_lot_size(slip.parking_slot.size),
                time_in:,
                time_out:,
                parking_fee: slip.total_parking_fee,
              })
              # puts slip.time_out.strftime("%A") 
            end
            render json: parking_slip_details
          end

          private

          def get_parking_lot_size(parking_lot_int_size)
            size_array = %w[SP MP LP]
            size_array[parking_lot_int_size]
          end
      end
    end
  end
end