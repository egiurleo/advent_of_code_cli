# frozen_string_literal: true

require "net/http"
require "uri"

module AdventOfCode
  module Commands
    class Download < Command
      def initialize(year:, day:)
        @year = year
        super(day: day)
      end

      def execute
        raise MissingCookieError unless cookie_present? && cookie

        say("Fetching input...")
        input = fetch_input

        unless Dir.exist?("inputs")
          say("Creating inputs directory...")
          Dir.mkdir("inputs")
        end

        say("Writing input to #{input_file_name}...")
        create_file(input_file_name, input)

        say("Done!", :green)
      end

      private

      def cookie
        @cookie ||= ENV.fetch("AOC_COOKIE", nil)
      end

      def cookie_present?
        ENV.key?("AOC_COOKIE")
      end

      def fetch_input
        url = URI("https://adventofcode.com/#{@year}/day/#{@day}/input")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["Cookie"] = "session=#{cookie}"
        # The creator of Advent of Code has requested that automated tools send identifying information
        # when making requests: https://www.reddit.com/r/adventofcode/comments/z9dhtd
        request["User-Agent"] = "github.com/egiurleo/advent_of_code_cli by emily.samp@icloud.com"

        response = https.request(request)
        response.read_body
      end
    end
  end
end
