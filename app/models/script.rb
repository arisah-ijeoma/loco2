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
end
