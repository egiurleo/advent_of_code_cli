# frozen_string_literal: true

module AdventOfCode
  module Commands
    module Example
      class Solve < Command
        def initialize(day:, name:)
          @name = name
          super(day: day)
        end

        def execute
          raise MissingExampleError unless File.exist?(example_file_name)
          raise MissingSolutionError unless File.exist?(solution_file_name)

          say "Reading input..."
          input = File.readlines(example_file_name, chomp: true)

          say "Loading solution..."
          load(solution_file_name)

          module_name = "Day#{day_string}"

          say "\nRunning part one with example #{@name}..."
          solution(module_name, "one", input)

          say "\nRunning part two with example #{@name}..."
          solution(module_name, "two", input)

          say "\nDone!", :green
        end

        private

        def solution(module_name, part, input)
          start_time = Time.now
          result = Object.const_get(module_name).send("part_#{part}", input)
          end_time = Time.now

          say "Part #{part} result: #{result}"
          say "Took #{end_time - start_time} seconds to solve"
        end
      end
    end
  end
end
