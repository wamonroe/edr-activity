RSpec.describe EDRActivity::Framework::Base, type: :file do
  it "is expected to pass arguments on to .new#call" do
    expect do
      EDRActivity::Framework::File.call(mode: :create, path: "tmp/file.txt", content: "example")
    end.not_to raise_error
  end
end
