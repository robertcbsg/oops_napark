class ParkingSlotSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :size, :is_available, :parking_lot_id

  has_many :distance_from_entries
  has_many :parking_slips
end
