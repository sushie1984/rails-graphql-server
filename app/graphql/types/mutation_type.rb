# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_department, mutation: Mutations::CreateDepartment
  end
end
