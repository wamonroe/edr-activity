require "socket"

require_relative "base"
require_relative "configuration"
require_relative "network_result"

module EDRActivity
  module Framework
    class Network < Base
      def initialize(protocol:, host:, port:, message:, options: {})
        @protocol = protocol
        @host = host
        @port = port
        @message = message
        @options = options
      end

      def call
        size = 0
        response = with_socket do |socket|
          size = socket.send(@message, 0)
        end
        log_activity(size)
        NetworkResult.new(response: response, size: size)
      end

      private

      def log_activity(size)
        EDRActivity::Framework.logger.info({
          activity: "network",
          network_source: "#{Socket.gethostname}:#{@port}",
          network_destination: "#{@host}:#{@port}",
          network_protocol: @protocol.to_s,
          network_bytes_sent: size
        })
      end

      def with_socket(&block)
        case @protocol
        when :udp
          with_udp_socket(&block)
        when :tcp
          with_tcp_socket(&block)
        else
          raise UnknownProtocolError, "unknown protocol - #{@protocol}"
        end
      end

      def with_udp_socket(&block)
        socket = UDPSocket.new
        socket.connect(@host, @port)
        block.call(socket)
        nil
      ensure
        socket.close
      end

      def with_tcp_socket(&block)
        response = nil
        Socket.tcp(@host, @port, connect_timeout: 10) do |socket|
          block.call(socket)
          response = socket.recv @options.fetch(:maxlen, 350)
        end
        response
      end
    end
  end
end
