class ParkingLot < ApplicationRecord
    has_many :parking_slots
    has_many :parking_entry_points
end
