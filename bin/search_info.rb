#!/usr/bin/env ruby

require 'active_support/core_ext/hash'
require './app/models/utilities'
require './app/models/search'
require './app/models/search_result'
require './app/models/connection'
require './app/models/fare'

search = Search.new('./task/search.xml')

prompter = "How would you like the output?\n"\
'Enter 1 to print to the terminal, 2 to write to a file or 0 to exit: '

print prompter
user_input = gets.chomp
return if user_input == '0'

# work on recalling prompter after refactoring
return print "Please enter a valid input\n" unless %w[1 2].include?(user_input)

if user_input == '1'
  print "There are #{search.results.count} search results\n\n"

  search.results.each_with_index do |result, i|
    search_result = SearchResult.new(result)
    print "#{i + 1}.\n"
    print "The details are as follows:\n"
    print " - ID: #{search_result.id}\n"
    print " - The entire journey will take #{search_result.formatted_total_trip_time}\n"
    print " - This trip has #{search_result.connections.count} connection(s) "\
  "and #{search_result.formatted_overlay.count} overlay(s)\n"
    print " - The overlay(s) will last #{search_result.formatted_overlay.join(', ')}\n\n"
    print "The following are the connection details:\n"
    search_result.connections.each_with_index do |cn, idx|
      print "Connection #{idx + 1}\n"
      print " - Train name: #{cn.train_name}\n"
      print " - The train will take off from #{cn.start} at #{cn.departure}\n"
      print " - It will arrive in #{cn.finish} at #{cn.arrival}\n"
      print " - The duration of this journey is #{cn.duration_in_hrs_mins}\n"
      print "   There are #{cn.fares.count} classes of fare(s) for this journey\n"
      cn.fares.each do |f|
        print "   - The #{f.name} fare costs GBP#{format('%.2f', f.price)}\n"
      end

      print "\n"
    end
  end


  print "The cheapest trip on this list is the trip with ID #{search.cheapest['ID']}\n"
  print "The quickest trip on this list is the trip with ID #{search.quickest['ID']}\n"
end
