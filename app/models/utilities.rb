# frozen_string_literal: true

module Utilities
  def time_conversion(duration)
    hours = (duration / 3600).to_i
    minutes = ((duration / 60) % 60).to_i

    # TODO - account for when we have 0 hours and/or 0 minutes
    "#{hours} hour(s) and #{minutes} minute(s)"
  end
end
