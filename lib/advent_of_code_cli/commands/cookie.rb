# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Cookie
      def initialize(value:)
        @value = value
      end

      def execute
        File.open("cookie.txt", "w") do |file|
          file.puts @value
        end
      end
    end
  end
end
