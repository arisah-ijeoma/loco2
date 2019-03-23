# frozen_string_literal: true

require 'rails_helper'

describe 'search results' do
  let(:file) { file_fixture('search.xml') }
  let(:results) { Search.new(file).results }
  let(:search_result) { SearchResult.new(result) }

  describe 'result 1' do
    let(:result) { results.first }

    it 'has correct details' do
      expect(search_result.id).to eq('F4S1DS')
      expect(search_result.connections.count).to eq(2)
    end
  end

  describe 'result 2' do
    let(:result) { results.second }

    it 'has correct details' do
      expect(search_result.id).to eq('L2FSF4')
      expect(search_result.connections.count).to eq(2)
    end
  end

  describe 'result 3' do
    let(:result) { results.third }

    it 'has correct details' do
      expect(search_result.id).to eq('D42GVV')
      expect(search_result.connections.count).to eq(3)
    end
  end
end
