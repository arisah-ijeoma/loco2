#!/usr/bin/env ruby

require 'active_support/core_ext/hash'
require './app/models/utilities'
require './app/models/search'
require './app/models/search_result'
require './app/models/train_connection'
require './app/models/fare'
require './app/models/script'


user_input = Script.user_input

return if user_input == '0'

if user_input == '1'
  print Script.parser
elsif user_input == '2'
  File.open('search_result.txt', 'w') { |file| file.puts(Script.parser) }
end
