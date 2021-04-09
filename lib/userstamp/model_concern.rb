module Userstamp::ModelConcern
  extend ActiveSupport::Concern

  include Userstamp::Stampable
  include Userstamp::Stamper
end
