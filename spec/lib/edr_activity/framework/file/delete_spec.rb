RSpec.describe EDRActivity::Framework::File, type: :file do
  subject(:file_activity) do
    described_class.new(mode: :delete, path: path)
  end

  let(:path) { "tmp/file.txt" }

  context "#delete" do
    context "when path present and it is a file" do
      before do
        FileUtils.touch(path)
      end

      it "is expected to delete a file with the content specified" do
        file_activity.call
        expect(File.exist?(path)).to be_falsey
      end

      it "is expected to log activity" do
        expect(EDRActivity::Framework.logger).to receive(:info)
        file_activity.call
      end
    end

    context "when path present and it is a folder" do
      before do
        Dir.mkdir(path)
      end

      it "is expected to raise an exception if the path points to a folder" do
        expect { file_activity.call }.to raise_error(EDRActivity::Framework::PathMismatchError)
      end
    end

    context "when path absent" do
      it "is expected to raise an exception if the file does not exist" do
        expect { file_activity.call }.to raise_error(EDRActivity::Framework::PathMissingError)
      end
    end
  end
end
