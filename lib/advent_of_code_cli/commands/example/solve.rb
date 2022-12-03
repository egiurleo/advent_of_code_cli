# frozen_string_literal: true

require "yaml"

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
          raise MissingExampleError unless File.exist?(example_expected_file_name)
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

          expected_result = expected_answers["part_#{part}"]

          if expected_result.nil?
            say "Part #{part} result: #{result} ⚠️  (no expectation provided)"
          elsif result == expected_result
            say "Part #{part} result: #{result} ✅"
          else
            say "Part #{part} result: #{result} ❌ (expected #{expected_result})"
          end

          say "Took #{end_time - start_time} seconds to solve"
        end

        def expected_answers
          @expected_answers ||= YAML.safe_load(File.read(example_expected_file_name))
        end
      end
    end
  end
end
