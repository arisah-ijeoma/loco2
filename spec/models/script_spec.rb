# frozen_string_literal: true

require 'rails_helper'

describe 'script' do
  describe '.user_input' do
    it 'returns only valid user input' do
      expect(Script.user_input).to eq('0').or(eq('1')).or(eq('2'))
    end

    it 'does not return invalid input' do
      expect(Script.user_input).not_to eq('3')
      expect(Script.user_input).not_to eq('w')
    end
  end
end
