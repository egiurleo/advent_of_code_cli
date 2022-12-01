# frozen_string_literal: true

module AdventOfCode
  module Commands
    class Scaffold < Command
      def execute
        say("Creating file: #{solution_file_name}...")
        create_file(solution_file_name, solution_file_contents)

        unless Dir.exist?("inputs")
          say("Creating inputs directory...")
          Dir.mkdir("inputs")
        end

        say("Creating file: #{input_file_name}...")
        create_file(input_file_name)

        unless Dir.exist?("examples")
          say("Creating examples directory...")
          Dir.mkdir("examples")
        end

        unless Dir.exist?("examples/#{day_string}")
          say("Creating examples/#{day_string} directory...")
          Dir.mkdir("examples/#{day_string}")
        end

        say "Done!", :green
      end

      private

      def solution_file_contents
        <<~RUBY
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
    end
  end
end
