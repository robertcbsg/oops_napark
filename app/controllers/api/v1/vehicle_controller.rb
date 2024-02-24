module Api
  module V1
    # Simulate time passing (for demo purposes)
    class VehicleController < ApplicationController
      def index
        vehicles = Vehicle.all

        render json: vehicles
      end
    end
  end
end