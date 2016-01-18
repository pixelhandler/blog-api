class Api::V1::PostsController < ApiControllerController
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resources]

  #def index
  #  render text: 'Bad Gateway', status: 502
  #end

  #def show
  #  render json: { errors: [ { title: 'Not Found' } ] }, status: 404
  #end

  #def update
  #  render json: { errors: [ { title:  "Invalid Attribute", } ] }, status: 422
  #end

  private
    def post_params
      params.require(:post).permit(:body, :excerpt, :slug, :title, :date)
    end
end
