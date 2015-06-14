class Api::V1::CommentsController < ApiControllerController
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resources]

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
      end
    end

    def comment_params
      params.require(:post).permit(:body, :approved)
    end
end
