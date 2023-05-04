RSpec.describe EDRActivity::Framework::Network do
  subject(:network_activity) do
    described_class.new(protocol: :dinosaur, host: "127.0.0.1", port: 8118, message: "hi")
  end

  it "is expected to raise an exception if passed an unknown protocol" do
    expect { network_activity.call }.to raise_error(EDRActivity::Framework::UnknownProtocolError)
  end
end
