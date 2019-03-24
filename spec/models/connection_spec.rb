# frozen_string_literal: true

require 'rails_helper'

describe 'connections' do
  let(:file) { file_fixture('search.xml') }
  let(:results) { Search.new(file).results }
  let(:result) { results.third }
  let(:search_result) { SearchResult.new(result) }
  let(:connections) { search_result.connections }

  describe 'trip 3 connection details' do
    describe 'connection 1' do
      let(:connection) { connections.first }

      it 'search result has correct connection details' do
        expect(connection.start).to eq('London St Pancras International')
        expect(connection.finish).to eq('Paris Nord')
        expect(connection.departure_time).to eq('2015-07-11T15:48:00+01:00')
        expect(connection.arrival_time).to eq('2015-07-11T19:03:00+02:00')
        expect(connection.train_name).to eq('Eurostar')
        expect(connection.fares.count).to eq(2)
      end

      describe '#duration_in_hrs_mins' do
        it 'converts duration correctly' do
          expect(connection.duration_in_hrs_mins).to eq('2 hour(s) and 15 minute(s)')
        end
      end
    end

    describe 'connection 2' do
      let(:connection) { connections.second }

      it 'search result has correct connection details' do
        expect(connection.start).to eq('Paris Lyon')
        expect(connection.finish).to eq('Perpignan')
        expect(connection.departure_time).to eq('2015-07-11T22:25:00+02:00')
        expect(connection.arrival_time).to eq('2015-07-12T06:48:00+02:00')
        expect(connection.train_name).to eq('Intercités de Nuit')
        expect(connection.fares.count).to eq(2)
      end

      describe '#duration_in_hrs_mins' do
        it 'converts duration correctly' do
          expect(connection.duration_in_hrs_mins).to eq('8 hour(s) and 23 minute(s)')
        end
      end
    end

    describe 'connection 3' do
      let(:connection) { connections.third }

      it 'search result has correct connection details' do
        expect(connection.start).to eq('Perpignan')
        expect(connection.finish).to eq('Barcelona Sants')
        expect(connection.departure_time).to eq('2015-07-12T09:57:00+02:00')
        expect(connection.arrival_time).to eq('2015-07-12T11:19:00+02:00')
        expect(connection.train_name).to eq('AVE Class 100')
        expect(connection.fares.count).to eq(2)
      end

      describe '#duration_in_hrs_mins' do
        it 'converts duration correctly' do
          expect(connection.duration_in_hrs_mins).to eq('1 hour(s) and 22 minutes(s)')
        end
      end
    end
  end
end
