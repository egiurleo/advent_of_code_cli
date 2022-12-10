# frozen_string_literal: true

module AdventOfCode
  module Commands
    class Scaffold < Command
      def execute

        unless File.exist?(solution_file_name)
          say("Creating file: #{solution_file_name}...")
          create_file(solution_file_name, solution_file_contents)
        end

        unless Dir.exist?("inputs")
          say("Creating inputs directory...")
          Dir.mkdir("inputs")
        end

        unless File.exist?(input_file_name)
          say("Creating file: #{input_file_name}...")
          create_file(input_file_name)
        end

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
