# frozen_string_literal: true

require_relative "lib/jazzicon/version"

Gem::Specification.new do |spec|
  spec.name = "jazzicon"
  spec.version = Jazzicon::VERSION
  spec.authors = ["Stephen Heuer"]
  spec.email = ["sheuer@aruxsoftware.com"]

  spec.summary = "A Ruby implementation of the javascript Jazzicon identicon generator."
  spec.description = "Jazzicon is a Ruby implementation of the javascript Jazzicon identicon generator (https://github.com/danfinlay/jazzicon)."
  spec.homepage = "https://github.com/Arux-Software/jazzicon_ruby"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*"]

  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_dependency "chunky_png", "~> 1.4"
  spec.metadata["rubygems_mfa_required"] = "true"
end
