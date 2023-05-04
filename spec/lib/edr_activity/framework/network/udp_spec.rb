require "socket"

RSpec.describe EDRActivity::Framework::Network do
  subject(:network_activity) do
    described_class.new(protocol: :udp, host: "127.0.0.1", port: @port, message: message)
  end

  let(:message) { "hello" }

  around do |ex|
    @server = UDPSocket.new
    @server.bind("127.0.0.1", 0)
    @port = @server.addr[1]
    ex.run
  ensure
    @server&.close
  end

  it "sends the message to the destination host and returns the response" do
    network_activity.call
    expect(@server.recv(350)).to eq("hello")
  end

  it "udp does not send a response" do
    expect(network_activity.call.response).to be_nil
  end

  it "returns the size, in bytes, of the message sent" do
    expect(network_activity.call.size).to eq(message.bytesize)
  end

  it "is expected to log activity" do
    expect(EDRActivity::Framework.logger).to receive(:info)
    network_activity.call
  end
end
