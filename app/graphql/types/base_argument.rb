module Types
  class BaseArgument < GraphQL::Schema::Argument
    argument :first, Integer, null: true, as: :limit
    argument :offset, Integer, null: true
  end
end
