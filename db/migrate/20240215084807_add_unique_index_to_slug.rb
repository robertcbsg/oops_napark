# frozen_string_literal: true

class AddUniqueIndexToSlug < ActiveRecord::Migration[7.1]
  def change
    add_index :parking_entry_points, :slug, unique: true
  end
end
