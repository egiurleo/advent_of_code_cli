# frozen_string_literal: true

module AdventOfCode
  module Commands
    class Command
      include Thor::Base

      def initialize(day:)
        raise InvalidDayError unless day.is_a?(Integer) && day.positive? && day <= 25

        @day = day
      end

      private

      def day_string
        @day < 10 ? "0#{@day}" : @day.to_s
      end

      def solution_file_name
        "#{day_string}.rb"
      end

      def input_file_name
        "inputs/#{day_string}.txt"
      end

      def example_file_name
        "examples/#{day_string}/#{@name}.txt"
      end

      def example_expected_file_name
        "examples/#{day_string}/#{@name}_expected.yml"
      end

      def create_file(file_name, contents = nil)
        File.open(file_name, "w") do |file|
          file.puts contents if contents
        end
      end
    end
  end
end
