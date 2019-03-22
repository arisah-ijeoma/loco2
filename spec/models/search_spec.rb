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

describe 'search' do
  let(:file) { file_fixture('search.xml') }
  let(:search) { Search.new(file) }

  describe 'search results' do
    it 'has the correct number of search results' do
      expect(search.results.count).to eq(3)
    end

    describe 'trips' do
      let(:connections) { search.connections[trip] }
      let(:fares) { search.fares }

      context 'trip 1' do
        let(:trip) { search.results.first['ID'] }

        describe 'connections' do
          it 'has the correct number of connections' do
            expect(connections.count).to eq(2)
          end

          describe 'fare' do
            let(:train) { connections.first['TrainName'] }

            it 'returns the correct fare type and price for trip' do
              expect(fares[train].first['Name']).to eq('Standard Class')
              expect(fares[train].last['Price']['Value']).not_to eq('79.00')
              expect(fares[train].last['Price']['Value']).to eq('159.00')
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
            let(:train) { connections.last['TrainName'] }

            it 'returns the correct fare type and price for trip' do
              expect(fares[train].last['Name']).to eq('First Class')
              expect(fares[train].last['Price']['Value']).to eq('30.00')
            end
          end
        end
      end
    end

    describe '#cheapest' do
      it 'returns the cheapest trip in the search' do
        # by summing the cheaper of the fares for a connection,
        # we can determine that the cheapest is the last result
        expect(search.cheapest).to eq(search.result.last)
      end
    end
  end
end
