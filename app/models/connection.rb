# frozen_string_literal: true

class Connection
  include Utilities
  attr_accessor :start, :finish, :departure_time, :arrival_time, :train_name, :fares

  def initialize(connection)
    @fares = connection['Fares']['Fare'].map do |fare|
      Fare.new(fare)
    end
    @start = connection['Start']
    @finish = connection['Finish']
    @departure_time = connection['DepartureTime']
    @arrival_time = connection['ArrivalTime']
    @train_name = connection['TrainName']
  end

  def arrival
    DateTime.parse(arrival_time).to_time.utc
  end

  def departure
    DateTime.parse(departure_time).to_time.utc
  end

  def formatted_duration
    duration = arrival - departure
    time_conversion(duration)
  end
end
