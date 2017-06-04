require 'jsonapi/resource'

class Api::V1::TagResource < JSONAPI::Resource
  attributes :name, :slug
  has_many :posts

  paginator :none

  before_save do
    @model.tenant = context[:tenant]
  end

  class << self
    def records(options = {})
      Tag.where(tenant: options[:context][:tenant])
    end

    # Find by slug or id
    def find_by_key(slug, options = {})
      context = options[:context]
      model = records(options).where(slug: slug).first
      if model.nil?
        model = records(options).where({ _primary_key => slug }).first
      end
      if model.nil?
        raise JSONAPI::Exceptions::RecordNotFound.new(slug)
      end
      self.new(model, context)
    end

    # override to allow for using slug as id
    def verify_key(key, context = nil)
      key && String(key)
    end
  end
end
