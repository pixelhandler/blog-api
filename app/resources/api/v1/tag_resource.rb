require 'jsonapi/resource'

class Api::V1::TagResource < JSONAPI::Resource
  attributes :id, :name
  has_many :posts

  paginator :none
end
