# frozen_string_literal: true

shared_examples 'shared_variables' do
  let(:file) { file_fixture('search.xml') }
  let(:search) { Search.new(file) }
  let(:results) { search.results }
end
