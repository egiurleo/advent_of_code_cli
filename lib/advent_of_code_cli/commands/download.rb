# frozen_string_literal: true

require "net/http"
require "uri"

module AdventOfCodeCli
  module Commands
    class Download < Command
      def initialize(year: Time.now.year, day:)
        @year = year

        super(day: day)
      end

      def execute
        raise MissingCookieError unless cookie

        # TODO: error handling
        input = fetch_input

        Dir.mkdir("inputs") unless Dir.exist?("inputs")
        File.open("inputs/#{day_string}.txt", "w") do |file|
          file.puts(input)
        end
      end

      private

      def cookie
        @cookie ||= File.read("cookie.txt").strip
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
