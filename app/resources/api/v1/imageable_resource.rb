class Api::V1::ImageableResource < JSONAPI::Resource
  attributes :name

  has_one :imageable, polymorphic: true
end
