# frozen_string_literal: true

require "thor"

require_relative "advent_of_code_cli/version"
require_relative "advent_of_code_cli/commands"

module AdventOfCode
  class Error < StandardError; end
  class ExampleAlreadyExistsError < Error; end
  class InvalidDayError < Error; end
  class MissingCookieError < Error; end
  class MissingExampleError < Error; end
  class MissingInputError < Error; end
  class MissingSolutionError < Error; end

  class CLI < Thor
    desc "scaffold DAY", "generate files for day DAY"
    def scaffold(day)
      AdventOfCode::Commands::Scaffold.new(day: day.to_i).execute
    rescue AdventOfCode::InvalidDayError
      rescue_invalid_day_error
    end

    desc "download DAY", "download your input for day DAY"
    option :year, default: Time.now.year.to_s
    def download(day)
      AdventOfCode::Commands::Download.new(day: day.to_i, year: options[:year].to_i).execute
    rescue AdventOfCode::InvalidDayError
      rescue_invalid_day_error
    rescue AdventOfCode::MissingCookieError
      say "Error: Cannot find cookie in the AOC_COOKIE environment variable.", :red
    end

    desc "solve DAY", "run your solutions for day DAY"
    def solve(day)
      AdventOfCode::Commands::Solve.new(day: day.to_i).execute
    rescue AdventOfCode::InvalidDayError
      rescue_invalid_day_error
    rescue AdventOfCode::MissingInputError
      say "Error: Cannot find input file.", :red
    rescue AdventOfCode::MissingSolutionError
      say "Error: Cannot find solution file.", :red
    end

    desc "example", "create and run example files"
    subcommand "example", Commands::Example::CLI

    private

    def rescue_invalid_day_error
      say "Error: The day argument must be an integer between 1 and 25.", :red
    end
  end
end
