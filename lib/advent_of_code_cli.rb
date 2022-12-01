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
      rescue_invalid_day_error
    end

    desc "cookie VALUE", "store your Advent of Code cookie with value VALUE in the cookie.txt file"
    def cookie(value)
      AdventOfCodeCli::Commands::Cookie.new(value: value).execute
    end

    desc "download DAY", "download your input for day DAY"
    option :year, default: Time.now.year.to_s
    def download(day)
      AdventOfCodeCli::Commands::Download.new(day: day.to_i, year: options[:year].to_i).execute
    rescue AdventOfCodeCli::InvalidDayError
      rescue_invalid_day_error
    rescue AdventOfCodeCli::MissingCookieError
      say "Error: Cannot find cookie in cookie.txt file.", :red
    end

    private

    def rescue_invalid_day_error
      say "Error: The day argument must be an integer between 1 and 25.", :red
    end
  end
end
