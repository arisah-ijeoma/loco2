# frozen_string_literal: true

require 'rails_helper'

# SEARCH
  # *** number of search results in sample xml
  # *** number of train changes (connections)
  # fare names and prices; compare fares in different connections (one connection might have first class and another would not)
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

    describe 'trips' do
      let(:connections) { search.trip_details[trip] }

      context 'trip 1' do
        let(:trip) { search.results.first['ID'] }

        describe 'connections' do
          it 'has the correct number of connections' do
            expect(connections.count).to eq(2)
          end

          describe 'fare' do
            it 'returns the correct fare type and price for trip' do
              expect(connections.first['Fares']['Fare'].first['Name']).to eq('Standard Class')
              expect(connections.first['Fares']['Fare'].last['Price']['Value']).not_to eq('79.00')
              expect(connections.first['Fares']['Fare'].last['Price']['Value']).to eq('159.00')
            end
          end
        end
      end

      context 'trip 2' do
        let(:trip) { search.results.last['ID'] }

        describe 'connections' do
          it 'has the correct number of connections' do
            expect(connections.count).to eq(3)
          end

          describe 'fare' do
            it 'returns the correct fare type and price for trip' do
              expect(connections.last['Fares']['Fare'].last['Name']).to eq('First Class')
              expect(connections.last['Fares']['Fare'].last['Price']['Value']).to eq('30.00')
            end
          end
        end
      end
    end
  end
end
