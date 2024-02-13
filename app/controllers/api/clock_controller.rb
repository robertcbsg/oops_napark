module Api
    class ClockController < ApplicationController
        # GET api/clock/
        def index
            clock = serializer(Clock.first)
            datetime_now = clock[:data][:attributes]

            render json: datetime_now
        end
        # GET api/clock/<param>
        # def show
        #     clock = Clock.first
        #     puts "[RDC] SHOW"
        #     render json: ClockSerializer.new(clock).serialized_json
        # end

        private

        def serializer(object)
            ClockSerializer.new(object).serializable_hash
        end
    end
end