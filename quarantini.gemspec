# frozen_string_literal: true

require_relative "lib/quarantini/version"

Gem::Specification.new do |spec|
  spec.name = "quarantini"
  spec.version = Quarantini::VERSION
  spec.authors = ["Phil Phillips"]
  spec.email = ["irving.phillips@gmail.com"]

  spec.summary = "A set of tools to remove tests from circulation"
  spec.homepage = "https://github.com/irphilli/#{spec.name}"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }

  spec.bindir = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable"
  spec.add_dependency "dry-struct"
  spec.add_dependency "dry-types"

  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("rubocop")
  spec.add_development_dependency("rubocop-performance")
  spec.add_development_dependency("rubocop-rake")
  spec.add_development_dependency("rubocop-rspec")
end
