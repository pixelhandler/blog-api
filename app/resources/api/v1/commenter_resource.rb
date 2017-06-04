require 'jsonapi/resource'

class Api::V1::CommenterResource < JSONAPI::Resource
  attributes :name
  attribute :hash
  has_many :comments

  before_save do
    @model.tenant = context[:tenant]
  end

  def hash
    @model.email_hash
  end

  def self.records(options = {})
    Commenter.where(tenant: options[:context][:tenant])
  end
end
