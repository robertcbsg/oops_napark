# frozen_string_literal: true

class ParkingSlip < ApplicationRecord
  belongs_to :vehicle
  belongs_to :parking_slot

  def calculate_parking_fee
    # [RDC] Perform the operation here

    # def calculate_average
    #   return 0 unless reviews.size.positive?
  
    #   avg = reviews.average(:score).to_f.round(2) * 100
    #   update_column(:average_score, avg)
    # end
  end
end
