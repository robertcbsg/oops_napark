# frozen_string_literal: true

class ParkingSlip < ApplicationRecord
  belongs_to :vehicle
  belongs_to :parking_slot
end
