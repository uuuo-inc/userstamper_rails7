module Userstamper::MigrationConcern
  extend ActiveSupport::Concern

  def userstamps(*args)
    config = Userstamper.config
    column(config.creator_attribute, :integer, *args)
    column(config.updater_attribute, :integer, *args)
  end
end
