class Api::V1::ImageablesController < ApiControllerController
  skip_before_action :authenticate_request

  private
    def imageable_params
      params.require(:imageable).permit(:name)
    end
end
