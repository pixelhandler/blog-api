class Api::V1::CommentersController < ApiControllerController
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resource]

  private

    def set_current_user
      if decoded_auth_token
        @current_user ||= Commenter.find(decoded_auth_token[:commenter_id])
        unless @current_user
          @current_user ||= User.find(decoded_auth_token[:user_id])
        end
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

    def commenter_params
      params.require(:post).permit(:name, :email)
    end

    def _default_sort
      [{:field=>"created_at", :direction=>:desc}]
    end
end
