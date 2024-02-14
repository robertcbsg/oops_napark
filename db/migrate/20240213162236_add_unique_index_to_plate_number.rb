# frozen_string_literal: true

class AddUniqueIndexToPlateNumber < ActiveRecord::Migration[7.1]
  def change
    add_index :vehicles, :plate_number, unique: true
  end
end
