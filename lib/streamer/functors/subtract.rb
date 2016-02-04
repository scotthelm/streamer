module Streamer
  module Functors
    # Subtract subtracts a set of terms
    class Subtract < Functor
      def call
        subtract
      end

      def subtract
        terms = options.fetch(:terms)
        initial_prop = terms.shift
        terms.inject(prop(initial_prop).to_f) do |total, item|
          total - prop(item).to_f
        end
      end
    end
  end
end
