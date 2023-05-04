require "yaml"

RSpec.describe EDRActivity::Framework::File, type: :file do
  subject(:file_activity) do
    described_class.new(mode: :update, path: path, content: content)
  end

  let(:path) { "tmp/file.txt" }
  let(:content) { "example content" }

  context "#update" do
    context "when path present and it is a file" do
      before do
        FileUtils.touch(path)
      end

      it "is expected to update a file with the content specified" do
        file_activity.call
        expect(File.read(path)).to eq(content)
      end

      context "with more complex data types" do
        let(:path) { "tmp/file.yaml" }
        let(:content) { data.to_yaml }
        let(:data) do
          {"key" => "value"}
        end

        it "is expected to update a file with the content specified" do
          file_activity.call
          expect(YAML.load_file(path)).to eq(data)
        end
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

      it "is expected to raise an exception" do
        expect { file_activity.call }.to raise_error(EDRActivity::Framework::PathMismatchError)
      end
    end

    context "when file absent" do
      it "is expected to raise an exception if the file does not exist" do
        expect { file_activity.call }.to raise_error(EDRActivity::Framework::PathMissingError)
      end
    end
  end
end
