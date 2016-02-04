module Streamer
  module Functors
    # Lte compares target to function or value
    class Lte < Functor
      def call
        compare :<=
      end
    end
  end
end
