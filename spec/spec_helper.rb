require 'bundler/setup'
Bundler.setup

require "simplecov"
SimpleCov.start

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
]

require "pry"

require "unearth"
