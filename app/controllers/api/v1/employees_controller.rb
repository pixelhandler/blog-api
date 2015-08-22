class Api::V1::EmployeesController < ApiControllerController
  skip_before_action :authenticate_request

  private
    def employee_params
      params.require(:employee).permit(:name)
    end
end
