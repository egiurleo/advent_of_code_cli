# frozen_string_literal: true

module AdventOfCodeCli
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
    end
  end
end
