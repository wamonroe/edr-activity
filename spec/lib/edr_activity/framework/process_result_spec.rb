RSpec.describe EDRActivity::Framework::ProcessResult do
  subject(:process_result) do
    described_class.new(stdout: stdout, stderr: stderr, status: status)
  end

  let(:stdout) { "output" }
  let(:stderr) { "errors" }
  let(:status) { instance_double("Process::Status") }

  it "is a simple value object containing the passed values" do
    expect(process_result.stdout).to eq(stdout)
    expect(process_result.stderr).to eq(stderr)
    expect(process_result.status).to eq(status)
  end

  it "delegates #success? to #status" do
    expect(status).to receive(:success?)
    process_result.success?
  end
end
