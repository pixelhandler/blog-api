require 'jsonapi/resource'

class Api::V1::PictureResource < JSONAPI::Resource
  attributes :id, :name

  has_one :imageable, polymorphic: true
end
