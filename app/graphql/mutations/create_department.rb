# frozen_string_literal: true

module Mutations
  class CreateDepartment < BaseMutation
    null true

    argument :attributes, InputObjects::DepartmentAttributes, required: true

    field :department, Types::DepartmentType, null: true
    field :errors, [String], null: false

    def resolve(attributes:)
      department = Department.new(attributes.to_h)
      if department.save
        { department: department, errors: [] }
      else
        { department: nil, errors: department.errors.full_messages }
      end
    end
  end
end
