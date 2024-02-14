# frozen_string_literal: true

class ParkingSlipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :time_in, :effective_time_in, :time_out, :total_parking_fee, :vehicle_id, :parking_slot_id
end
