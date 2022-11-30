# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Scaffold < Command
      def execute
        File.open("#{day_string}.rb", "w").close

        Dir.mkdir("inputs") unless Dir.exist?("inputs")
        File.open("inputs/#{day_string}.txt", "w").close

        Dir.mkdir("examples") unless Dir.exist?("examples")
        File.open("examples/#{day_string}.txt", "w").close
      end
    end
  end
end
