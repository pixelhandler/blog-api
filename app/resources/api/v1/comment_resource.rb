require 'jsonapi/resource'

class Api::V1::CommentResource < JSONAPI::Resource
  attributes :id, :body, :approved
  has_one :commenter
  has_one :post
end
