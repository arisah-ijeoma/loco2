# frozen_string_literal: true

class Script
  def self.prompter
    prompt = ''
    prompt += "How would you like the output?\n"
    prompt += 'Enter 1 to print to the terminal, 2 to write to a file or 0 to exit: '
    prompt
  end

  def self.user_input
    print prompter

    input = STDIN.gets.chomp
    return user_input unless %w[0 1 2].include?(input)
    input
  end

  def self.parser
    search = Search.new('./task/search.xml')

    pp search

    details = ''
    details += "There are #{search.results.count} search results\n\n"

    # parser - push line by line string into empty string
    search.results.each_with_index do |result, i|
      search_result = SearchResult.new(result)
      details += "#{i + 1}.\n"
      details += "The details are as follows:\n"
      details += " - ID: #{search_result.id}\n"
      details += " - The entire journey will take #{search_result.total_trip_time_in_hrs_mins}\n"
      details += " - This trip has #{search_result.connections.count} connection(s) "
      details += "and #{search_result.overlay_in_hrs_mins.count} overlay(s)\n"
      details += " - The overlay(s) will last #{search_result.overlay_in_hrs_mins.join(', ')}\n\n"
      details += "The following are the connection details:\n"
      search_result.connections.each_with_index do |cn, idx|
        details += "Connection #{idx + 1}\n"
        details += " - Train name: #{cn.train_name}\n"
        details += " - The train will take off from #{cn.start} at #{cn.departure_in_utc}\n"
        details += " - It will arrive in #{cn.finish} at #{cn.arrival_in_utc}\n"
        details += " - The duration of this journey is #{cn.duration_in_hrs_mins}\n"
        details += "   There are #{cn.fares.count} classes of fare(s) for this journey\n"
        cn.fares.each do |f|
          details += "  - The #{f.name} fare costs GBP#{format('%.2f', f.price)}\n"
        end

        details += "\n"
      end
    end


    details += "The cheapest trip on this list is the trip with ID #{search.cheapest['ID']}\n"
    details += "The quickest trip on this list is the trip with ID #{search.quickest['ID']}\n"

    details
  end
end
