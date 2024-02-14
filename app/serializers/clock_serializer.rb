# frozen_string_literal: true

class ClockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :datetime_now
end
