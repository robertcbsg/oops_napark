# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

clock = Clock.create([{ datetime_now: Time.now}])

parking_lot = ParkingLot.create([
    {
        name: "OOPs Parking Lot"
    }
])

parking_entry_points = ParkingEntryPoint.create([
    {
        name: "North Exit",
        parking_lot_id: parking_lot[0].id
    },
    {
        name: "West Exit",
        parking_lot_id: parking_lot[0].id
    },
    {
        name: "Southwest Exit",
        parking_lot_id: parking_lot[0].id
    }
])

parking_slots = ParkingSlot.create([
    {
        size: 2,
        is_available: false,
        parking_lot_id: parking_lot[0].id
    },
    {
        size: 1,
        is_available: false,
        parking_lot_id: parking_lot[0].id
    },
    {
        size: 0,
        is_available: false,
        parking_lot_id: parking_lot[0].id
    }
])

# [RDC] For demo purposes
parking_slots.each do |slot|
    parking_entry_points.each do |entry|
        DistanceFromEntry.create({
            distance: rand(1..5),
            parking_slot_id: slot.id,
            parking_entry_point_id: entry.id
        })
    end
end

vehicles = Vehicle.create([
    {
        plate_number: "CDN103",
        is_parked: false,
        size: 1
    },
    {
        plate_number: "ASI129",
        is_parked: false,
        size: 0
    }
])
