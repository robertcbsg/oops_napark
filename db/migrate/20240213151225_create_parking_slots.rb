class CreateParkingSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_slots do |t|
      t.integer :size
      t.boolean :is_available
      t.belongs_to :parking_lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
