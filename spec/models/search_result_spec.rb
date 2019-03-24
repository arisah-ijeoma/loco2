# frozen_string_literal: true

require 'rails_helper'

describe 'search results' do
  let(:file) { file_fixture('search.xml') }
  let(:results) { Search.new(file).results }
  let(:search_result) { SearchResult.new(result) }
  let(:connections) { search_result.connections }

  describe 'result 1' do
    let(:result) { results.first }

    it 'has correct details' do
      expect(search_result.id).to eq('F4S1DS')
      expect(connections.count).to eq(2)
    end

    # the first result has 2 connections

    describe 'time before connection 2' do
      it 'has correct data' do
        expect(search_result.overlay.first).to eq('1 hour(s) and 15 minute(s)')
      end
    end
  end

  describe 'result 2' do
    let(:result) { results.second }

    it 'has correct details' do
      expect(search_result.id).to eq('L2FSF4')
      expect(connections.count).to eq(2)
    end

    describe 'time before next connection' do
      # the second result has 2 connections

      describe 'time before connection 2' do
        it 'has correct data' do
          expect(search_result.overlay.first).to eq('0 hour(s) and 44 minute(s)')
        end
      end
    end
  end

  describe 'result 3' do
    let(:result) { results.third }

    it 'has correct details' do
      expect(search_result.id).to eq('D42GVV')
      expect(connections.count).to eq(3)
    end

    describe 'time before next connection' do
      # the third result has 3 connections

      describe 'time before connection 2' do
        it 'has correct data' do
          expect(search_result.overlay.first).to eq('3 hour(s) and 22 minute(s)')
        end
      end

      describe 'time before connection 3' do
        it 'has correct data' do
          expect(search_result.overlay.second).to eq('3 hour(s) and 9 minute(s)')
        end
      end
    end
  end
end
