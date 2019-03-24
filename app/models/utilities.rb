# frozen_string_literal: true

module Utilities
  def time_conversion(duration)
    hours = (duration / 3600).to_i
    minutes = ((duration / 60) % 60).to_i
    "#{hours} hour(s) and #{minutes} minute(s)"
  end
end
