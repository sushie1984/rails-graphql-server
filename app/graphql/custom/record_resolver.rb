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
          when /_from\z/
            from_key = key[0..-6]
            model.where("#{from_key} >= ?", value)
          when /_to\z/
            to_key = key[0..-4]
            model.where("#{to_key} <= ?", value)
          else
            model.where(key => value)
          end
        end
      end
    end
  end
end
