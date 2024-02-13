class ParkingEntryPointSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :parking_lot_id

  has_many :distance_from_entries
end
