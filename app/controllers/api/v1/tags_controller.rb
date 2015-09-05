class Api::V1::TagsController < ApiControllerController
  skip_before_action :authenticate_request, only: [:index, :show, :show_association, :get_related_resources]

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
