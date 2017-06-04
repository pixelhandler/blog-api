require 'jsonapi/resource'

class Api::V1::PostResource < JSONAPI::Resource
  attributes :title, :slug, :excerpt, :date, :body
  has_one :author
  has_many :comments
  has_many :tags

  paginator :offset

  filter :search

  class << self
    # Support search filter using class method
    def apply_filter(records, filter, value, _options = {})
      if records.respond_to? filter.to_sym
        value = value.join(' ') if filter.to_sym == :search
        records.send(filter.to_sym, value)
      else
        records.where(filter => value)
      end
    end

    # Find by slug or id
    def find_by_key(slug, options = {})
      context = options[:context]
      model = records(options).where(slug: slug).first
      if model.nil?
        model = records(options).where({_primary_key => slug}).first
      end
      if model.nil?
        raise JSONAPI::Exceptions::RecordNotFound.new(slug)
      end
      self.new(model, context)
    end

    def count(options = {})
      records(options).count
    end

    # override to allow for using slug as id
    def verify_key(key, context = nil)
      key && String(key)
    end
  end

end
