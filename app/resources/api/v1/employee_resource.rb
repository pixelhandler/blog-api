require 'jsonapi/resource'

class Api::V1::EmployeeResource < JSONAPI::Resource
  attributes :id, :name

  has_many :pictures
end
