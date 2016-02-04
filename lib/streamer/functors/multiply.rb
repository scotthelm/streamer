module Streamer
  module Functors
    # Multiply multiplies a set of terms together
    class Multiply < Functor
      def call
        multiply
      end

      def multiply
        options.fetch(:terms).inject(1) do |total, item|
          unless item.is_a?(String) || item.is_a?(Numeric)
            fail "Streamer::Functor invalid term: #{item}"
          end
          val = total * (prop(item) || 0) if item.is_a? String
          val = total * item if item.is_a? Numeric
          val
        end
      end
    end
  end
end
