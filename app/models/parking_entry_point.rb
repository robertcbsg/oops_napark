class ParkingEntryPoint < ApplicationRecord
  belongs_to :parking_lot
  has_many :distance_from_entries
end
