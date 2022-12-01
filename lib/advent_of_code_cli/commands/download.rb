# frozen_string_literal: true

require "net/http"
require "uri"

module AdventOfCodeCli
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
        @cookie ||= File.read("cookie.txt").strip
      end

      def cookie_present?
        File.exist?("cookie.txt")
      end

      def fetch_input
        url = URI("https://adventofcode.com/#{@year}/day/#{@day}/input")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["Cookie"] = "session=#{cookie}"

        response = https.request(request)
        response.read_body
      end
    end
  end
end
