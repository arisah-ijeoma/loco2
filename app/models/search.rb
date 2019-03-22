# frozen_string_literal: true

class Search
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def results
    search_hash['SearchResult']
  end

  def connections
    details = {}

    results.each do |result|
      details[result['ID']] = result['Connections']['Connection']
    end

    details
  end

  def fares
    details = {}
    x = 0

    connections.each do |id, connection|
      details[connection[x]['TrainName']] = connection[x]['Fares']['Fare']
      x += 1
    end

    details
  end

  def search_hash
    Hash.from_xml(file_content)['SearchResults']
  end

  def file_content
    File.read(file)
  end
end
