# frozen_string_literal: true

class SearchResult
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
      arrival = DateTime.parse(cn.arrival_time)
      departure = DateTime.parse(cn.departure_time)
      [arrival.to_time.utc, departure.to_time.utc].inject(:-)
    end.inject(:+)
  end
end
