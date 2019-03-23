# frozen_string_literal: true

class Fare
  attr_accessor :name, :price

  def initialize(fare)
    @name = fare['Name']
    @price = fare['Price']['Value']
  end
end
