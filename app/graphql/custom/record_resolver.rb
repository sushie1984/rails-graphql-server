module Custom
  class RecordResolver
    class << self
      def query(model_object, conditions)
        return model_object.all if conditions.empty?

        conditions.reduce(model_object) do |model, (key, value)|
          case key.to_s
          when /limit/
            model.limit(value)
          when /offset/
            model.offset(value)
          else
            model.where(key => value)
          end
        end
      end
    end
  end
end
