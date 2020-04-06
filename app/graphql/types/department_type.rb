# frozen_string_literal: true

module Types
  class DepartmentType < Types::BaseObject
    field :id, ID, 'The unique id of the department', null: false
    field :name, String, 'The name of the department', null: true
    field :location,
          String,
          'The name of the phyiscal location of this department',
          null: true
    field :employees,
          [EmployeeType, null: true],
          'A list of employees working in this department',
          null: true

    def employees
      object.employees
    end
  end
end
