# frozen_string_literal: true

class SearchResult
  attr_accessor :id, :connections

  def initialize(search_result)
    @id = search_result['ID']
    @connections = search_result['Connections']['Connection'].map do |cn|
      Connection.new(cn)
    end
  end
end
