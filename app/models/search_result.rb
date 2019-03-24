# frozen_string_literal: true

class SearchResult
  include Utilities
  attr_accessor :id, :connections

  def initialize(search_result)
    @id = search_result['ID']
    @connections = search_result['Connections']['Connection'].map do |cn|
      Connection.new(cn)
    end
  end

  def minimum_fares
    connections.map do |cn|
      cn.fares.map(&:price).min
    end.inject(:+)
  end

  def fastest_time
    connections.map do |cn|
      [cn.arrival, cn.departure].inject(:-)
    end.inject(:+)
  end

  def overlay
    overlay = connections.map.with_index do |cn, i|
      next if i.zero?
      [cn.departure, connections[i - 1].arrival].inject(:-)
    end.compact

    overlay.map { |item| time_conversion(item) }
  end
end
