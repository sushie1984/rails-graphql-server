module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
    argument :first, Integer, null: true, as: :limit
    argument :offset, Integer, null: true
  end
end
