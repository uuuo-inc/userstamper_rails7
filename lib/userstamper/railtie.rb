module Userstamper
  class Railtie < Rails::Railtie
    initializer "userstamper.action_controller" do
      ActiveSupport.on_load(:action_controller_base) do
        include Userstamper::ControllerConcern
      end

      ActiveSupport.on_load(:active_record) do
        include Userstamper::ModelConcern

        ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Userstamper::MigrationConcern)
      end
    end
  end
end
