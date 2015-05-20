# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unearth/version'

Gem::Specification.new do |spec|
  spec.name          = "unearth"
  spec.version       = Unearth::VERSION
  spec.authors       = ["Amy Sutedja", "Zachary Drummond"]
  spec.email         = ["asutedja@biaprotect.com", "zdrummond@biaprotect.com"]
  spec.summary       = "NewRelic Insights Query Gem"
  spec.description   = "Easy querying of the NewRelic Insights API"
  spec.homepage      = "https://github.com/BIAINC/unearth"
  spec.license       = "none"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec", "~>3.0.0"
  spec.add_development_dependency "simplecov", "~>0.8.2"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4.0"
  spec.add_development_dependency "pry", "~> 0.10.0"

  spec.add_dependency "httparty"
end
