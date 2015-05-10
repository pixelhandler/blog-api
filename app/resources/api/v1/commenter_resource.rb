require 'jsonapi/resource'

class Api::V1::CommenterResource < JSONAPI::Resource
  attributes :id, :name
  has_many :comments
end
