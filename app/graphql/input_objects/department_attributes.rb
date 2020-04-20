# frozen_string_literal: true

module InputObjects
  class DepartmentAttributes < Types::BaseInputObject
    description 'Attributes for modifying a department entry'
    argument :name, String, 'The name of the department', required: true
    argument :location, String, 'The location of the deparment', required: true
  end
end
