# frozen_string_literal: true

class ParkingLotSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  has_many :parking_slots
  has_many :parking_entry_points
end
