# frozen_string_literal: true

require_relative "advent_of_code_cli/version"
require_relative "advent_of_code_cli/commands"

module AdventOfCodeCli
  class Error < StandardError; end
  class MissingCookieError < Error; end
  class MissingInputError < Error; end
  class MissingSolutionError < Error; end
end
