# frozen_string_literal: true

require "thor"

require_relative "advent_of_code_cli/version"
require_relative "advent_of_code_cli/commands"

module AdventOfCodeCli
  class Error < StandardError; end
  class InvalidDayError < Error; end
  class MissingCookieError < Error; end
  class MissingInputError < Error; end
  class MissingSolutionError < Error; end
end

module AdventOfCode
  class CLI < Thor
    desc "scaffold DAY", "generate files for day DAY"
    def scaffold(day)
      AdventOfCodeCli::Commands::Scaffold.new(day: day.to_i).execute
    rescue AdventOfCodeCli::InvalidDayError
      say "Error: The day argument must be an integer between 1 and 25.", :red
    end
  end
end
