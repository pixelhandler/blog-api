class Api::V1::AuthorsController < ApiControllerController
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resource]

  private
    def author_params
      params.require(:author).permit(:name, :email, :post_id)
    end
end
