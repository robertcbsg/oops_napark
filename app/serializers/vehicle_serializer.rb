# frozen_string_literal: true

class VehicleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :plate_number, :is_parked, :size

  has_many :parking_slips
end
