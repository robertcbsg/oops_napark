class ClockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :datetime_now
end
