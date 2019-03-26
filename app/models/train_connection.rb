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

  def arrival_in_utc
    DateTime.parse(arrival_time).to_time.utc
  end

  def departure_in_utc
    DateTime.parse(departure_time).to_time.utc
  end

  def duration_in_hrs_mins
    duration = arrival_in_utc - departure_in_utc
    time_conversion(duration)
  end
end
