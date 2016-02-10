module Streamer
  module Functors
    # Group groups a list by a property and a function
    class Group < Functor
      def call
        group
      end

      def group
        group_key = options.fetch(:by)
        operand_key = options.fetch(:operand)
        operator = options.fetch(:operator).to_sym
        accumulate(list, group_key, operand_key, operator)
      end

      def accumulate(list, group_key, operand_key, operator)
        list.each_with_object({}) do |item, val|
          val[item[group_key]] =
            (val[item[group_key]] || 0.0).send(
              operator,
              (item[operand_key].to_f || 0)
            )
        end
      end
    end
  end
end
