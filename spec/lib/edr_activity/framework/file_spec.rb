RSpec.describe EDRActivity::Framework::File, type: :file do
  subject(:file_activity) do
    described_class.new(path: path, mode: mode)
  end

  let(:path) { "tmp/file.txt" }
  let(:mode) { :taco }

  it "is expected to raise an exception when called with an unknown mode" do
    expect { file_activity.call }.to raise_error(EDRActivity::Framework::UnknownModeError)
  end
end
