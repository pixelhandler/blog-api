class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  validates :tenant, inclusion: { in: %w(pixelhandler billandlorraine),
    message: "%{value} is not a valid tenant" }
end
