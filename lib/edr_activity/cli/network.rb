require "thor"
require "edr_activity/framework/network"

module EDRActivity
  module CLI
    class Network < Thor
      desc "tcp HOST PORT", "generate tcp network activity"
      option :message, required: true, desc: "message sent"
      def tcp(host, port)
        EDRActivity::Framework::Network.call(
          protocol: :tcp,
          host: host,
          port: port,
          message: options[:message]
        )
      end

      desc "udp HOST PORT", "generate udp network activity"
      option :message, required: true, desc: "message sent"
      def udp(host, port)
        EDRActivity::Framework::Network.call(
          protocol: :udp,
          host: host,
          port: port,
          message: options[:message]
        )
      end
    end
  end
end
