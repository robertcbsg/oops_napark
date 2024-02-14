# frozen_string_literal: true

class ParkingSlot < ApplicationRecord
  belongs_to :parking_lot
  has_many :parking_slips
  has_many :distance_from_entries
end
