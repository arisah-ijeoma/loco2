# frozen_string_literal: true

require 'rails_helper'

describe Search do
  include_examples 'shared_variables'

  describe 'search results' do
    it 'has the correct number of search results' do
      expect(search.results.count).to eq(3)
    end
  end

  describe '#cheapest' do
    # by summing up the cheaper fares on the connections,
    # we can come up with the cheapest
    it 'returns the cheapest search result' do
      expect(search.cheapest).to eq(search.results.third)
    end
  end

  describe '#quickest' do
    # by summing up the differences between arrival and departure for each
    # connection along with the overlay, we can come up with the quickest
    it 'returns the quickest search result' do
      expect(search.quickest).to eq(search.results.second)
    end
  end
end
