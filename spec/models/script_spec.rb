# frozen_string_literal: true

require 'rails_helper'

describe 'script' do
  describe '.user_input' do
    describe do
      it 'returns only valid user input' do
        allow(STDIN).to receive(:gets) { '1' }
        expect(Script.user_input).to eq('1')
      end
    end

    describe 'invalid input' do
      it 'does not return invalid input' do
        allow(STDIN).to receive(:gets) { '3' }
        allow(STDIN).to receive(:gets) { '2' }
        expect(Script.user_input).not_to eq('3')
        expect(Script.user_input).to eq('2')
      end
    end
  end
end
