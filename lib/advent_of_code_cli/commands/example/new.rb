# frozen_string_literal: true

module AdventOfCode
  module Commands
    module Example
      class New < Command
        def initialize(day:, name:)
          @name = name
          super(day: day)
        end

        def execute
          unless Dir.exist?("examples")
            say("Creating examples directory...")
            Dir.mkdir("examples")
          end

          unless Dir.exist?("examples/#{day_string}")
            say("Creating examples/#{day_string} directory...")
            Dir.mkdir("examples/#{day_string}")
          end

          if File.exist?(example_file_name)
            raise ExampleAlreadyExistsError.new(
              "could not create example file because file #{example_file_name} already exists"
            )
          end

          say("Creating #{example_file_name}...")
          create_file(example_file_name)

          say "Done!", :green
        end
      end
    end
  end
end
