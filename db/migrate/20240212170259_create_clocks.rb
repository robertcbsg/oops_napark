# frozen_string_literal: true

class CreateClocks < ActiveRecord::Migration[7.1]
  def change
    create_table :clocks do |t|
      t.datetime :datetime_now

      t.timestamps
    end
  end
end
