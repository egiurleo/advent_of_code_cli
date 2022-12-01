# frozen_string_literal: true

require "thor"

require_relative "advent_of_code_cli/version"
require_relative "advent_of_code_cli/commands"

module AdventOfCode
  class Error < StandardError; end
  class InvalidDayError < Error; end
  class MissingCookieError < Error; end
  class MissingInputError < Error; end
  class MissingSolutionError < Error; end

  class CLI < Thor
    desc "scaffold DAY", "generate files for day DAY"
    def scaffold(day)
      AdventOfCode::Commands::Scaffold.new(day: day.to_i).execute
    rescue AdventOfCode::InvalidDayError
      rescue_invalid_day_error
    end

    desc "cookie VALUE", "store your Advent of Code cookie with value VALUE in the cookie.txt file"
    def cookie(value)
      AdventOfCode::Commands::Cookie.new(value: value).execute
    end

    desc "download DAY", "download your input for day DAY"
    option :year, default: Time.now.year.to_s
    def download(day)
      AdventOfCode::Commands::Download.new(day: day.to_i, year: options[:year].to_i).execute
    rescue AdventOfCode::InvalidDayError
      rescue_invalid_day_error
    rescue AdventOfCode::MissingCookieError
      say "Error: Cannot find cookie in cookie.txt file.", :red
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

    private

    def rescue_invalid_day_error
      say "Error: The day argument must be an integer between 1 and 25.", :red
    end
  end
end
