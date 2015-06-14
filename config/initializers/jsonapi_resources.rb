require 'jsonapi/counting_active_record_operations_processor'
require 'jsonapi/offset_paginator'

JSONAPI.configure do |config|
  # custom processor to include total count of resources
  config.operations_processor = :counting_active_record

  # built in paginators are :none, :offset, :cursor, :paged
  config.default_paginator = :offset

  config.default_page_size = 5
  config.maximum_page_size = 100
end
