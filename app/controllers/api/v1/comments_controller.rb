class Api::V1::CommentsController < ApiControllerController
  skip_before_action :set_current_user, :authenticate_request, only: [:index, :show, :show_association, :get_related_resources]
  before_action :set_current_user

  def current_user
    @current_user
  end

  private

    def context
      self
    end

    def set_current_user
      if decoded_auth_token
        if decoded_auth_token.has_key? :commenter_id
          @current_user = Commenter.find(decoded_auth_token[:commenter_id])
        elsif decoded_auth_token.has_key? :user_id
          @current_user = User.find(decoded_auth_token[:user_id])
        end
        nil
      end
    end

    def _serializer
      JSONAPI::ResourceSerializer.new(resource_klass,
                                      include: @request.include,
                                      fields: @request.fields,
                                      base_url: base_url,
                                      key_formatter: key_formatter,
                                      route_formatter: route_formatter)
    end

    def comment_params
      params.require(:post).permit(:body, :approved)
    end

    def _default_sort
      [{:field=>"created_at", :direction=>:desc}]
    end
end
