class AddSlugToParkingEntryPoints < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_entry_points, :slug, :string
  end
end
