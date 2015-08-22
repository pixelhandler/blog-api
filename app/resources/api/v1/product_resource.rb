require 'jsonapi/resource'

class Api::V1::ProductResource < JSONAPI::Resource
  attributes :id, :name

  has_many :pictures
end
