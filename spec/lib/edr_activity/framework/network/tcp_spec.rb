require "socket"

RSpec.describe EDRActivity::Framework::Network do
  subject(:network_activity) do
    described_class.new(protocol: :tcp, host: "127.0.0.1", port: @port, message: message)
  end

  let(:message) { "hello" }

  around do |ex|
    @server = TCPServer.new("127.0.0.1", 0)
    @port = @server.addr[1]
    fork do
      loop do
        client = @server.accept
        client.print "hello there"
        client.close
        break
      end
    end
    ex.run
  ensure
    @server&.close
  end

  it "sends the message to the destination host and returns the response" do
    expect(network_activity.call.response).to eq("hello there")
  end

  it "returns the size, in bytes, of the message sent" do
    expect(network_activity.call.size).to eq(message.bytesize)
  end

  it "is expected to log activity" do
    expect(EDRActivity::Framework.logger).to receive(:info)
    network_activity.call
  end
end
