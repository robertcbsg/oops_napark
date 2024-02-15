# frozen_string_literal: true

module Api
  module V1
    # Simulate time passing (for demo purposes)
    class ClockController < ApplicationController
      def index
        clock = Clock.first

        datetime_now = clock.datetime_now

        render json: datetime_now
      end

      def create
        clock = Clock.first
        current_datetime = clock.datetime_now

        clock.datetime_now = current_datetime + params[:hours].to_i.hours + params[:minutes].to_i.minutes
        clock.save

        render json: { previous_time: current_datetime, clock: }
      end
    end
  end
end
