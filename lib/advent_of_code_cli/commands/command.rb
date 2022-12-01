# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Command
      def initialize(day:)
        unless day.is_a?(Integer) && day > 0 && day < 26
          raise ArgumentError.new("#{day} is not a valid day argument; must be an integer between 1 and 25")
        end

        @day = day
      end

      private

      def day_string
        @day < 10 ? "0#{@day}" : @day.to_s
      end
    end
  end
end