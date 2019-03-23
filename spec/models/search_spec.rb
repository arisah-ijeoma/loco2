# frozen_string_literal: true

require 'rails_helper'

# SEARCH
  # *** number of search results in sample xml
  # *** number of train changes (connections)
  # *** fare names and prices; compare fares in different connections (one connection might have first class and another would not)
  # add value of connection, determine cheapest in sample data
  # check time for a full trip, determine fastest in sample data
# TIME
  # arrival and departure time are in local time
    # use the date to determine what the time should be calculated
  # duration of connection in hours and minutes
  # duration before connection in trips
#
# refactor tests after work completion

describe 'search' do
  let(:file) { file_fixture('search.xml') }
  let(:search) { Search.new(file) }

  describe 'search results' do
    it 'has the correct number of search results' do
      expect(search.results.count).to eq(3)
    end
  end

  describe '#cheapest' do
    it 'returns the cheapest search result' do
      expect(search.cheapest).to eq(search.results.third)
    end
  end
end
