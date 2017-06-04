JSONAPI.configure do |config|
  # :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :offset

  config.default_page_size = 20
  config.maximum_page_size = 100
end
