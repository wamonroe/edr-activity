require_relative "lib/edr_activity/version"

Gem::Specification.new do |spec|
  spec.name = "edr-activity"
  spec.version = EDRActivity::VERSION
  spec.authors = ["Alex Monroe"]
  spec.email = ["alex@monroepost.com"]

  spec.summary = "Framework to support testing an EDR agent"
  spec.description = "Framework that allos us to test an EDR agent and ensure " \
                     "it generates the appropriate telemetry."
  spec.homepage = "https://github.com/wamonroe/edr-activity"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,exe,lib}/**/*", "CHANGELOG.md", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.2", ">= 1.2.1"
end
