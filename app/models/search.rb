# frozen_string_literal: true

class Search
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def results
    search_hash['SearchResult'].each do |result|
      SearchResult.new(result)
    end
  end

  def search_hash
    Hash.from_xml(file_content)['SearchResults']
  end

  def file_content
    File.read(file)
  end

  def cheapest
    # returns the cheapest total along with the search result index
    min_index = search_hash['SearchResult'].map do |result|
      SearchResult.new(result).minimum_fares
    end.each_with_index.min

    search_hash['SearchResult'][min_index[1]]
  end
end
