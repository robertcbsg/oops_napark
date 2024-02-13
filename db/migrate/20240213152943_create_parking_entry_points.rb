class CreateParkingEntryPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_entry_points do |t|
      t.string :name
      t.belongs_to :parking_lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
