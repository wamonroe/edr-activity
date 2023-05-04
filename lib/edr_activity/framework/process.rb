require "open3"

require_relative "configuration"
require_relative "process_result"

module EDRActivity
  module Framework
    class Process < Base
      def initialize(process:, args: [])
        @process = process
        @args = args
      end

      def call
        stdout, stderr, status = Open3.capture3(@process, *@args)
        log_activity(status&.pid)
        ProcessResult.new(stdout: stdout, stderr: stderr, status: status)
      end

      private

      def log_activity(process_id)
        EDRActivity::Framework.logger.info({
          activity: "process",
          process_started_name: @process,
          process_started_args: @args,
          process_started_id: process_id
        })
      end
    end
  end
end
