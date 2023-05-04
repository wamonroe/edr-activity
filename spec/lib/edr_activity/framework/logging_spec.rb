RSpec.describe EDRActivity::Framework, type: :file do
  subject(:logger) { described_class.logger }

  before do
    described_class.configure do |config|
      config.logger = ::Logger.new(STDOUT) # rubocop:disable Style/GlobalStdStream
    end
  end

  it "is expected to write logs in json" do
    expect { logger.info({}) }.to output(/\A\{"severity":.*,"timestamp":.*,"username":.*,"process_name":.*,"process_id":.*\}\n\z/).to_stdout_from_any_process
  end

  it "is expected it include additional json" do
    expect { logger.info({example: "text"}) }.to output(/"example":"text"/).to_stdout_from_any_process
  end
end
