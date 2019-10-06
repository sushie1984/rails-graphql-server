class GraphqlServerSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
