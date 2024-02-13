class CreateDistanceFromEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :distance_from_entries do |t|
      t.integer :distance
      t.belongs_to :parking_entry_point, null: false, foreign_key: true
      t.belongs_to :parking_slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
