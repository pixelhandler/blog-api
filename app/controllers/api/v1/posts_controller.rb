class Api::V1::PostsController < ApiControllerController
  include Api::V1::Context
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resources]

  private
    def post_params
      params.require(:post).permit(:body, :excerpt, :slug, :title, :date, :status)
    end
end
