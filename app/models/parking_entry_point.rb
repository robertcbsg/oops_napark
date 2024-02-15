# frozen_string_literal: true

class ParkingEntryPoint < ApplicationRecord
  belongs_to :parking_lot
  has_many :distance_from_entries

  validates :name, presence: true

  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end
end