require 'jsonapi/resource'

class Api::V1::CommentResource < JSONAPI::Resource
  attributes :body, :created_at
  attribute :approved
  has_one :commenter
  has_one :post

  before_save do
    @model.tenant = context[:tenant]
  end

  def approved
    if user_is_authorized or comment_owned_by_commenter?(@model)
      return @model.approved
    end
  end

  def fetchable_fields
    user_is_known ? super : super - [:approved]
  end

  def self.records(options = {})
    Comment.where(tenant: options[:context][:tenant])
  end

  private

    def current_user
      context.respond_to?(:current_user) ? context.current_user : nil
    end

    def user_is_commenter
      current_user.present? and current_user.is_a? Commenter
    end

    def user_is_authorized
      current_user.present? and current_user.is_a? User
    end

    def user_is_known
      user_is_commenter or user_is_authorized
    end

    def comment_owned_by_commenter?(model)
      user_is_commenter and model.commenter.id == current_user.id
    end
end
