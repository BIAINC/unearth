require "httparty"

require "unearth/configuration"
require "unearth/query"
require "unearth/relation"
require "unearth/version"

module Unearth
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
