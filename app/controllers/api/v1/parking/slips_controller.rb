# frozen_string_literal: true

module Api
  module V1
    module Parking
      class SlipsController < ApplicationController
          def show
            parking_slips = ParkingSlip.all.order('id desc').limit(5)

            render json: parking_slips
          end
      end
    end
  end
end