# frozen_string_literal: true

require 'rails_helper'

describe Fare do
  include_examples 'shared_variables'

  let(:result) { results.second }
  let(:search_result) { SearchResult.new(result) }
  let(:connection) { search_result.connections.first }
  let(:fare) { fare }

  describe 'trip 2 connection details' do
    describe 'fares in first connection' do
      describe 'first fare details' do
        let(:fare) { connection.fares.first }

        it 'has the correct details' do
          expect(fare.name).to eq('Standard Class')
          expect(fare.price).to eq(69)
        end
      end

      describe 'second fare details' do
        let(:fare) { connection.fares.second }

        it 'has the correct details' do
          expect(fare.name).to eq('Standard Premier')
          expect(fare.price).to eq(179)
        end
      end
    end
  end
end
