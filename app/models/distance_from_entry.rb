# frozen_string_literal: true

class DistanceFromEntry < ApplicationRecord
  belongs_to :parking_entry_point
  belongs_to :parking_slot
end
