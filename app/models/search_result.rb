# frozen_string_literal: true

class SearchResult
  include Utilities
  attr_accessor :id, :connections

  def initialize(search_result)
    @id = search_result['ID']
    @connections = search_result['Connections']['Connection'].map do |cn|
      TrainConnection.new(cn)
    end
  end

  def minimum_fares
    connections.map do |cn|
      cn.fares.map(&:price).min
    end.inject(:+)
  end

  def trip_time
    connections.map do |cn|
      [cn.arrival_in_utc, cn.departure_in_utc].inject(:-)
    end.inject(:+)
  end

  #  TODO - account for when there is no overlay
  def overlay
    connections.map.with_index do |cn, i|
      next if i.zero?
      [cn.departure_in_utc, connections[i - 1].arrival_in_utc].inject(:-)
    end.compact
  end

  def overlay_in_hrs_mins
    overlay.map { |item| time_conversion(item) }
  end

  def total_trip_time
    trip_time + overlay.inject(:+)
  end

  def total_trip_time_in_hrs_mins
    time_conversion(total_trip_time)
  end
end
