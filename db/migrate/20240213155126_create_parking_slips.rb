# frozen_string_literal: true

class CreateParkingSlips < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_slips do |t|
      t.datetime :time_in
      t.datetime :effective_time_in
      t.datetime :time_out
      t.decimal :total_parking_fee
      t.belongs_to :vehicle, null: false, foreign_key: true
      t.belongs_to :parking_slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
