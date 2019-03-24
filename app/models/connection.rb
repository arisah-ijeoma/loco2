# frozen_string_literal: true

class Connection
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

  def duration_in_hrs_mins
    duration = arrival - departure
    time_conversion(duration)
  end

  private

  def time_conversion(duration)
    hours = (duration / 3600).to_i
    minutes = ((duration / 60) % 60).to_i
    "#{hours}:#{minutes}"
  end
end
