module Userstamp
  class Railtie < Rails::Railtie
    initializer "userstamp.action_controller" do
      ActiveSupport.on_load(:action_controller_base) do
        include Userstamp::ControllerConcern
      end

      ActiveSupport.on_load(:active_record) do
        include Userstamp::ModelConcern

        ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Userstamp::MigrationConcern)
      end
    end
  end
end
