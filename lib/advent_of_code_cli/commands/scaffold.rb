# frozen_string_literal: true

module AdventOfCodeCli
  module Commands
    class Scaffold < Command
      def execute
        File.open("#{day_string}.rb", "w") do |file|
          file.puts <<~RUBY
            module Day#{day_string}
              class << self
                def part_one(input)
                  raise NotImplementedError
                end

                def part_two(input)
                  raise NotImplementedError
                end
              end
            end
          RUBY
        end

        Dir.mkdir("inputs") unless Dir.exist?("inputs")
        File.open("inputs/#{day_string}.txt", "w").close

        Dir.mkdir("examples") unless Dir.exist?("examples")
        Dir.mkdir("examples/#{day_string}") unless Dir.exist?("examples/#{day_string}")
      end
    end
  end
end
