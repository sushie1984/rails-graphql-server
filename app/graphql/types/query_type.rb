# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :departments, [DepartmentType], 'Query for departments', null: true do
      argument :id, [ID], required: false
      argument :name, [String], required: false
      argument :location, [String], required: false
    end

    def departments(**args)
      Custom::RecordResolver.query(Department, args)
    end

    field :currencies, [CurrencyType], 'Query for currencies', null: true do
      argument :base, [String], required: false
      argument :publishedAtFrom,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               as: :published_at_from
      argument :publishedAtTo,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               as: :published_at_to
    end

    def currencies(**args)
      Custom::RecordResolver.query(Currency, args)
    end
  end
end
