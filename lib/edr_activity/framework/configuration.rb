require "logger"
require "time"
require "json"

module EDRActivity
  module Framework
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def logger
        configuration.logger
      end
    end

    class Configuration
      attr_reader :logger

      def initialize
        self.logger = ::Logger.new("logs/edr-activity.log")
      end

      def logger=(new_logger)
        @logger = new_logger.tap do |logger|
          logger.formatter = default_formatter
        end
      end

      def default_formatter
        @default_formatter ||= ->(severity, datetime, process_name, message) {
          {
            severity: severity,
            timestamp: datetime.iso8601,
            username: username,
            process_name: process_name || $PROGRAM_NAME,
            process_args: ARGV,
            process_id: ::Process.pid
          }.merge!(message).to_json + "\n"
        }
      end

      private

      def username
        user = ENV.fetch("USER", ENV["USERNAME"])
        if !Gem.win_platform? && ENV["SUDO_USER"]
          user = "#{ENV["SUDO_USER"]} (#{user})"
        end
        user
      end
    end
  end
end
