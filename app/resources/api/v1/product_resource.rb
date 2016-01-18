require 'jsonapi/resource'

class Api::V1::ProductResource < JSONAPI::Resource
  attributes :name

  has_many :pictures
end
