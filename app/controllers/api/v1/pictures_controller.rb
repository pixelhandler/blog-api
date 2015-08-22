class Api::V1::PicturesController < ApiControllerController
  skip_before_action :authenticate_request

  private
    def picture_params
      params.require(:picture).permit(:name, :imageable_id)
    end
end
