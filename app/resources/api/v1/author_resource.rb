require 'jsonapi/resource'

class Api::V1::AuthorResource < JSONAPI::Resource
  attributes :name, :email
  has_many :posts

  before_save do
    @model.tenant = context[:tenant]
  end

  def self.records(options = {})
    Author.where(tenant: options[:context][:tenant])
  end
end
