class Api::V1::ProductsController < ApiControllerController
  skip_before_action :authenticate_request

  private
    def product_params
      params.require(:product).permit(:name)
    end
end
