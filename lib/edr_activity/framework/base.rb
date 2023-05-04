require_relative "configuration"

module EDRActivity
  module Framework
    class Base
      def self.call(...)
        new(...).call
      end
    end
  end
end
