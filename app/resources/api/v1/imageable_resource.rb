class Api::V1::ImageableResource < JSONAPI::Resource
  attributes :id, :name

  has_one :imageable, polymorphic: true
end
