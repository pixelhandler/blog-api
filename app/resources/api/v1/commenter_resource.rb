require 'jsonapi/resource'

class Api::V1::CommenterResource < JSONAPI::Resource
  attributes :id, :name
  attribute :hash
  has_many :comments

  def hash
    @model.email_hash
  end
end
