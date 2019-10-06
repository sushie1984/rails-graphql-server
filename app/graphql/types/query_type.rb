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
  end
end
