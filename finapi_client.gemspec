# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require 'finapi_client/version'

Gem::Specification.new do |spec|
  spec.name          = "finapi_client"
  spec.version       = "0.0.0"
  # spec.version       = FinAPIClient::VERSION
  spec.authors       = ["croaker"]
  spec.summary       = "A simple client for the finapi.io API"
  spec.description   = "A simple client for the finapi.io API"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
