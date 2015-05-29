require 'jsonapi/resource'

class Api::V1::CommentResource < JSONAPI::Resource
  attributes :id, :body, :approved, :created_at
  has_one :commenter
  has_one :post
end
