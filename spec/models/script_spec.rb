# frozen_string_literal: true

require 'rails_helper'

describe Script do
  describe '.user_input' do
    describe do
      before { allow(STDIN).to receive(:gets) { '1' } }

      it 'returns only valid user input' do
        expect(Script.user_input).to eq('1')
      end
    end

    describe 'invalid input' do
      before do
        allow(STDIN).to receive(:gets) { '3' }
        allow(STDIN).to receive(:gets) { '2' }
      end

      it 'does not return invalid input' do
        expect(Script.user_input).not_to eq('3')
        expect(Script.user_input).to eq('2')
      end
    end
  end

  describe '.parser' do
    let(:results) {
      [{"ID"=>"F4S1DS",
        "Connections"=>
          {"Connection"=>
            [{"Start"=>"London St Pancras International",
              "Finish"=>"Paris Nord",
              "DepartureTime"=>"2015-07-11T09:23:00+01:00",
              "ArrivalTime"=>"2015-07-11T12:41:00+02:00",
              "TrainName"=>"Eurostar",
              "Fares"=>
                {"Fare"=>
                  [{"Name"=>"Standard Class",
                    "Price"=>{"Currency"=>"GBP", "Value"=>"79.00"}},
                    {"Name"=>"Standard Premier",
                      "Price"=>{"Currency"=>"GBP", "Value"=>"159.00"}}]}},
              {"Start"=>"Paris Lyon",
                "Finish"=>"Barcelona Sants",
                "DepartureTime"=>"2015-07-11T13:56:00+02:00",
                "ArrivalTime"=>"2015-07-11T20:17:00+02:00",
                "TrainName"=>"TGV 2N2",
                "Fares"=>
                  {"Fare"=>
                    [{"Name"=>"Standard Class",
                      "Price"=>{"Currency"=>"GBP", "Value"=>"50.00"}},
                      {"Name"=>"First Class",
                        "Price"=>{"Currency"=>"GBP", "Value"=>"75.00"}}]}}]}}] }

    let(:response) {
      "There are 1 search results\n" +
        "\n" +
        "1.\n" +
        "The details are as follows:\n" +
        " - ID: F4S1DS\n" +
        " - The entire journey will take 9 hour(s) and 54 minute(s)\n" +
        " - This trip has 2 connection(s) and 1 overlay(s)\n" +
        " - The overlay(s) will last 1 hour(s) and 15 minute(s)\n" +
        "\n" +
        "The following are the connection details:\n" +
        "Connection 1\n" +
        " - Train name: Eurostar\n" +
        " - The train will take off from London St Pancras International at 2015-07-11 08:23:00 UTC\n" +
        " - It will arrive in Paris Nord at 2015-07-11 10:41:00 UTC\n" +
        " - The duration of this journey is 2 hour(s) and 18 minute(s)\n" +
        "   There are 2 classes of fare(s) for this journey\n" +
        "  - The Standard Class fare costs GBP79.00\n" +
        "  - The Standard Premier fare costs GBP159.00\n" +
        "\n" +
        "Connection 2\n" +
        " - Train name: TGV 2N2\n" +
        " - The train will take off from Paris Lyon at 2015-07-11 11:56:00 UTC\n" +
        " - It will arrive in Barcelona Sants at 2015-07-11 18:17:00 UTC\n" +
        " - The duration of this journey is 6 hour(s) and 21 minute(s)\n" +
        "   There are 2 classes of fare(s) for this journey\n" +
        "  - The Standard Class fare costs GBP50.00\n" +
        "  - The First Class fare costs GBP75.00\n" +
        "\n" +
        "The cheapest trip on this list is the trip with ID F4S1DS\n" +
        "The quickest trip on this list is the trip with ID F4S1DS\n"

    }

    it 'returns correct parsed strings matching results' do
      allow_any_instance_of(Search).to receive(:results) { results }
      expect(Script.parser).to eq(response)
    end
  end
end
