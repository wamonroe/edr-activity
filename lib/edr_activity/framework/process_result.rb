require "open3"

module EDRActivity
  module Framework
    class ProcessResult < Base
      attr_reader :stdout, :stderr, :status

      def initialize(stdout:, stderr:, status:)
        @stdout = stdout
        @stderr = stderr
        @status = status
      end

      def success?
        status.success?
      end
    end
  end
end
