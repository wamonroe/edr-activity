if %w[true 1 t on yes].include?(ENV["COVERAGE"]&.downcase)
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    add_filter "/spec/"
  end
end

require "fileutils"
require "pathname"
require "pry-byebug"
require "edr_activity"

def root_dir
  @root_dir ||= Pathname.new(File.expand_path("..", __dir__))
end

def clean_tmp_dir
  root_dir.join("tmp").children.each do |path|
    next if path.basename.to_s == ".keep"

    if path.file?
      File.delete(path)
    elsif path.directory?
      FileUtils.rm_rf(path)
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.before(:suite) do
    clean_tmp_dir
  end

  config.after(:each, type: :file) do
    clean_tmp_dir
  end
end
