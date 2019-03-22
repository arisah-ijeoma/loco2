# frozen_string_literal: true

require 'rails_helper'

# SEARCH
  # *** number of search results in sample xml
  # number of train changes (connections)
  # fare names and prices; compare fares in different connections (one connection
  # might have first class and another would not)
  # add value of connection, determine cheapest in sample data
  # check time for a full trip, determine fastest in sample data
# TIME
  # arrival and departure time are in local time
    # use the date to determine what the time should be calculated
  # duration of connection in hours and minutes
  # duration before connection in trips

describe 'search information' do
  let(:file) { file_fixture('search.xml') }
  let(:search) { Search.new(file) }

  describe 'search results' do
    it 'has the correct number of search results' do
      expect(search.results.count).to eq(3)
    end

    describe 'connections' do
      let(:first_trip) { search.results.first['ID'] }
      let(:last_trip) { search.results.last['ID'] }

      it 'has the correct number of connections per trip' do
        expect(search.connections[first_trip]).to eq(2)
        expect(search.connections[last_trip]).to eq(3)
      end
    end
  end
end
