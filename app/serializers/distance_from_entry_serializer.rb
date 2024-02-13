class DistanceFromEntrySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :distance, :parking_entry_point_id, :parking_slot_id
end
