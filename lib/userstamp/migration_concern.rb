module Userstamp::MigrationConcern
  extend ActiveSupport::Concern

  def userstamps(*args)
    config = Userstamp.config
    column(config.creator_attribute, :integer, *args)
    column(config.updater_attribute, :integer, *args)
    column(config.deleter_attribute, :integer, *args) if config.deleter_attribute.present?
  end
end
