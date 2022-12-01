# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Solve < Command
      def initialize(day:, part:)
        unless part == 1 || part == 2
          raise ArgumentError.new("#{part} is an invalid part argument; must be 1 or 2")
        end

        @part = part
        super(day: day)
      end

      def execute
        unless File.exist?(input_file_name)
          raise MissingInputError
        end

        unless File.exist?(solution_file_name)
          raise MissingSolutionError
        end

        input = File.read(input_file_name).strip
        load(solution_file_name)

        module_name = "Day#{day_string}"
        method_name = @part == 1 ? "part_one" : "part_two"

        Object.const_get(module_name).send(method_name)
      end

      private

      def input_file_name
        @input_file_name ||= "inputs/#{day_string}.txt"
      end

      def solution_file_name
        @solution_file_name ||= "#{day_string}.rb"
      end
    end
  end
end
