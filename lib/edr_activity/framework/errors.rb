module EDRActivity
  module Framework
    class Error < StandardError; end

    class PathExistsError < Error; end

    class PathMismatchError < Error; end

    class PathMissingError < Error; end

    class UnknownModeError < Error; end

    class UnknownProtocolError < Error; end
  end
end
