# frozen_string_literal: true

module Types
  class EmployeeType < Types::BaseObject
    field :id, ID, 'The unique id of the employee', null: false
    field :name, String, 'The name of the employee', null: true
    field :age, Integer, 'The age of the employee', null: true
    field :yearlySalary,
          Float,
          'The salary of a year the employee earns',
          null: true,
          method: :yearly_salary
    field :workStart,
          String,
          'The first working day of the employee',
          null: true,
          method: :work_start
    field :departments,
          [DepartmentType, null: true],
          'A list of departments this employee belongs to',
          null: true

    delegate :departments, to: :object
  end
end
