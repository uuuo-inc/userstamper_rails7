require "active_support"
require "active_support/rails"
require "active_support/concern"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module Userstamper
  # Retrieves the configuration for the Userstamper gem.
  # @return [Userstamper::Configuration]
  def self.config
    Configuration
  end

  # Configures the gem.
  # @yield [Userstamper::Configuration] The configuration for the gem.
  def self.configure
    yield config
  end
end

require "userstamper/railtie" if defined?(Rails::Railtie)
