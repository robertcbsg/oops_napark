# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :parking_slips
end
