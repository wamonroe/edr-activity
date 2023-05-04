RSpec.describe MDRActivity::Framework::Process do
  let(:process) { "ls" }

  context "without args" do
    subject(:results) do
      described_class.new(process: process).call
    end

    it "is expected to launch the specified process without arguments" do
      expect(results).to be_success
      expect(results.stdout).to include("spec")
    end

    it "is expected to log activity" do
      expect(MDRActivity::Framework.logger).to receive(:info)
      results
    end
  end

  context "with args" do
    subject(:results) do
      described_class.new(process: process, args: args).call
    end

    let(:args) { ["-la", "./exe"] }

    it "is expected to launch the specified process with arguments" do
      expect(results).to be_success
      expect(results.stdout).to include("mdr-activity")
    end

    it "is expected to log activity" do
      expect(MDRActivity::Framework.logger).to receive(:info)
      results
    end
  end
end
