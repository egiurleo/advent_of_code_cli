# frozen_string_literal: true

require_relative "example/new"
require_relative "example/solve"

module AdventOfCode
  module Commands
    module Example
      class CLI < Thor
        desc "new DAY NAME", "creates an example file with name NAME for day DAY"
        def new(day, name)
          New.new(day: day.to_i, name: name).execute
        rescue ExampleAlreadyExistsError => e
          say(e.message, :red)
        rescue InvalidDayError
          rescue_invalid_day_error
        end

        desc "solve DAY NAME", "runs the example with name NAME for day DAY"
        def solve(day, name)
          Solve.new(day: day.to_i, name: name).execute
        rescue InvalidDayError
          rescue_invalid_day_error
        rescue MissingExampleError
          say "Error: Cannot find example file.", :red
        rescue AdventOfCode::MissingSolutionError
          say "Error: Cannot find solution file.", :red
        end

        private

        def rescue_invalid_day_error
          say "Error: The day argument must be an integer between 1 and 25.", :red
        end
      end
    end
  end
end
