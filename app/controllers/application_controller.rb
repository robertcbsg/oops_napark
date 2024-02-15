# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # TODO: Implement user auth
  protect_from_forgery with: :null_session

  def serializer(object)
    object_class = object.is_a?(ActiveRecord::Relation) ? object[0].class : object.class
    object_data = object.is_a?(ActiveRecord::Relation) ? object : [object]

    serializer = get_serializer(object_class)
    puts "No serializer for #{object_class}" unless serializer

    serializer.new(object_data).serializable_hash
  end

  def get_serializer(object_class)
    if object_class == ParkingLot
      ParkingLotSerializer
    elsif object_class == ParkingEntryPoint
      ParkingEntryPointSerializer
    elsif object_class == ParkingSlot
      ParkingSlotSerializer
    elsif object_class == DistanceFromEntry
      DistanceFromEntrySerializer
    elsif  object_class == Vehicle
      VehicleSerializer
    elsif object_class == ParkingSlip
      ParkingSlipSerializer
    elsif object_class == Clock
      ClockSerializer
    end
  end
end
