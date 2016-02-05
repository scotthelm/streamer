module Streamer
  module Functors
    # Average gives the average of a list given a property.
    class Average < Functor
      def call
        Divide.new(
          payload,
          terms: [total, count]
        ).call
      end

      def total
        Sum.new(
          payload,
          list: options.fetch(:list),
          property: options.fetch(:property)
        ).call
      end

      def count
        Count.new(payload, list: options.fetch(:list)).call
      end
    end
  end
end
