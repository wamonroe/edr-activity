module EDRActivity
  module Framework
    class NetworkResult
      attr_reader :response, :size

      def initialize(response:, size:)
        @response = response
        @size = size
      end
    end
  end
end
