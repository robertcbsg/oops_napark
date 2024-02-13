class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :plate_number
      t.boolean :is_parked
      t.integer :size

      t.timestamps
    end
  end
end
