# frozen_string_literal: true

module Api
  module V1
    class UnparkController < ApplicationController
      def index
        msg = get_time_now

        render json: { message: msg }
      end

      def create
        parking_slip = ParkingSlip.find_by(id: params[:parking_slip_id].to_i)

        if !parking_slip || parking_slip.time_out
          error = 'Invalid parking slip, please double check the id.'
          return render json: { error: }, status: 422
        end

        parking_slot = ParkingSlot.find_by(id: parking_slip.parking_slot_id)
        vehicle = Vehicle.find_by(id: parking_slip.vehicle_id)

        time_out = get_time_now
        duration_in_seconds = time_out - parking_slip.effective_time_in

        total_parking_fee = calculate_parking_fee(duration_in_seconds, parking_slot.size)

        ActiveRecord::Base.transaction do
          parking_slot.update(is_available: true)
          vehicle.update(is_parked: false)
          parking_slip.update(time_out:, total_parking_fee:)
        end

        render json: { total_parking_fee: }
      end

      private

      FLAT_RATE = 40 # first three hours
      EXCEEDING_HOURLY_RATE = {
        'SP' => 20,
        'MP' => 60,
        'LP' => 100
      }.freeze
      FULL_DAY_RATE = 5_000

      def calculate_parking_fee(duration_in_seconds, parking_lot_int_size)
        parking_lot_size = get_parking_lot_size(parking_lot_int_size)
        duration = (duration_in_seconds / 1.hour).ceil

        total_parking_fee = 0
        if duration >= 24
          num_of_full_day_blocks = (duration / 24).round
          total_parking_fee += num_of_full_day_blocks * FULL_DAY_RATE

          duration -= num_of_full_day_blocks * 24
          total_parking_fee + duration * EXCEEDING_HOURLY_RATE[parking_lot_size]
        elsif duration > 3
          total_parking_fee += FLAT_RATE

          duration -= 3
          total_parking_fee + duration * EXCEEDING_HOURLY_RATE[parking_lot_size]
        else
          FLAT_RATE
        end
      end

      def get_parking_lot_size(parking_lot_int_size)
        size_array = %w[SP MP LP]
        size_array[parking_lot_int_size]
      end
    end
  end
end
