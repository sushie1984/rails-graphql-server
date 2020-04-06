# frozen_string_literal: true

module Api
  class GraphqlController < ApiController
    def execute
      variables = ensure_hash(params[:variables])
      query = params[:query]
      operation_name = params[:operationName]
      context = {
        # Query context goes here, for example:
        # current_user: current_user,
      }
      result = schema_query(query, variables, context, operation_name)
      render json: result
    rescue StandardError => e
      raise e unless Rails.env.development?

      handle_error_in_development e
    end

    private

    def schema_query(query, variables, context, operation_name)
      GraphqlServerSchema.execute(query,
                                  variables: variables,
                                  context: context,
                                  operation_name: operation_name)
    end

    # Handle form data, JSON body, or a blank value
    def ensure_hash(ambiguous_param)
      case ambiguous_param
      when String
        to_hash(ambiguous_param)
      when Hash, ActionController::Parameters
        ambiguous_param
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
      end
    end

    def to_hash(ambiguous_param)
      return {} if ambiguous_param.blank?

      ensure_hash(JSON.parse(ambiguous_param))
    end

    def handle_error_in_development(err)
      logger.error err.message
      logger.error err.backtrace.join("\n")

      render json:
        {
          error: { message: err.message, backtrace: err.backtrace },
          data: {}
        }, status: 500
    end
  end
end
