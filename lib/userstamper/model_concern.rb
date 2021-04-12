module Userstamper::ModelConcern
  extend ActiveSupport::Concern

  include Userstamper::Stampable
  include Userstamper::Stamper
end
