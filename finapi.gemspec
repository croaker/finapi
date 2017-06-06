# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finapi/version'

Gem::Specification.new do |spec|
  spec.name                  = "finapi"
  spec.version               = FinAPI::VERSION
  spec.authors               = ["croaker"]
  spec.summary               = "A simple client for the finapi.io API"
  spec.description           = "A simple client for the finapi.io API"
  spec.license               = "MIT"

  spec.files                 = `git ls-files -z`.split("\x0")
  spec.executables           = spec.files.grep(%r{^bin/}) {|f| File.basename(f)}
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ["lib"]
  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency "faraday", "~> 0.12"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
