require 'jsonapi/resource'

class Api::V1::PictureResource < JSONAPI::Resource
  attributes :id, :name, :updated_at, :created_at

  has_one :imageable, polymorphic: true
end
