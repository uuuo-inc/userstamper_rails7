require "active_support"
require "active_support/rails"
require "active_support/concern"

# require "active_record"
# require "active_record/base"
# require "active_record/connection_adapters/abstract/schema_definitions"
# require "action_controller"
# require "action_controller/base"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module Userstamp
  # Retrieves the configuration for the userstamp gem.
  # @return [Userstamp::Configuration]
  def self.config
    Configuration
  end

  # Configures the gem.
  # @yield [Userstamp::Configuration] The configuration for the gem.
  def self.configure
    yield config
  end
end


# ActiveSupport.on_load(:active_record) do
  # require "zeitwerk"
  # loader = Zeitwerk::Loader.for_gem
  # loader.setup

  # module Userstamp
    # # autoload :Configuration
    # # autoload :Stampable
    # # autoload :Stamper
    # # autoload :Utilities

    # # eager_autoload do
      # # autoload :ControllerAdditions
      # # autoload :MigrationAdditions
      # # autoload :ModelAdditions
    # # end

    # # Retrieves the configuration for the userstamp gem.
    # #
    # # @return [Userstamp::Configuration]
    # # def self.config
      # # Configuration
    # # end

    # # Configures the gem.
    # #
    # # @yield [Userstamp::Configuration] The configuration for the gem.
    # # def self.configure
      # # yield config
    # # end

    # # eager_load!
  # end

  # loader.eager_load
# end

require "userstamp/railtie" if defined?(Rails::Railtie)
