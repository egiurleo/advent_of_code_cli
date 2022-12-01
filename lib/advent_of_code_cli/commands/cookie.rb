# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Cookie
      def initialize(value:)
        @value = value
      end

      def execute
        say "Creating cookie.txt file..."
        File.open("cookie.txt", "w") do |file|
          file.puts @value
        end

        say "Done!", :green
      end
    end
  end
end
