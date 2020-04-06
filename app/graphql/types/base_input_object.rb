# frozen_string_literal: true

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    # argument :first, Integer, null: true, as: :limit
    # argument :offset, Integer, null: true
  end
end
