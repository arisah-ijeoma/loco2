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
    train_changes = {}

    results.each do |result|
      train_changes[result['ID']] = result['Connections']['Connection'].count
    end

    train_changes
  end

  def search_hash
    Hash.from_xml(file_content)['SearchResults']
  end

  def file_content
    File.read(file)
  end
end
